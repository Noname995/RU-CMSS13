import { Component, createRef } from 'inferno';

// this file should probably not be in interfaces, should move it later.
export class CanvasLayer extends Component {
  constructor(props) {
    super(props);
    this.canvasRef = createRef();
    
    // color selection
    // using this.state prevents unpredictable behavior
    this.state = {
      selection: this.props.selection,
    };
   
    // needs to be of type png of jpg
    this.img = null;
    this.imageSrc = this.props.imageSrc;
    
    // stores the stacked lines
    this.lineStack = [];
    
    // stores the individual line drawn
    this.currentLine = [];

    this.ctx = null;
    this.isPainting = false;
    this.lastX = null;
    this.lastY = null;
  }

  componentDidMount() {
    this.ctx = this.canvasRef.current.getContext('2d');
    this.ctx.lineWidth = 4;
    this.ctx.lineCap = 'round';

    this.img = new Image();

    // hardcoded value for testing pngs
    // this.img.src = "https://cm-ss13.com/wiki/images/6/6f/LV624.png"

    this.img.src = this.imageSrc;

    this.drawCanvas();

    this.canvasRef.current.addEventListener('mousedown', this.handleMouseDown);
    this.canvasRef.current.addEventListener('mousemove', this.handleMouseMove);
    this.canvasRef.current.addEventListener('mouseup', this.handleMouseUp);
  }

  componentWillUnmount() {
    this.canvasRef.current.removeEventListener(
      'mousedown',
      this.handleMouseDown
    );
    this.canvasRef.current.removeEventListener(
      'mousemove',
      this.handleMouseMove
    );
    this.canvasRef.current.removeEventListener('mouseup', this.handleMouseUp);
  }

  handleMouseDown = (e) => {
    this.isPainting = true;

    const rect = this.canvasRef.current.getBoundingClientRect();
    const x = e.clientX - rect.left;
    const y = e.clientY - rect.top;

    this.ctx.beginPath();
    this.ctx.moveTo(this.lastX, this.lastY);
    this.lastX = x;
    this.lastY = y;
  };

  handleMouseMove = (e) => {
    if (!this.isPainting || !this.state.selection) {
      return;
    }

     // defaults to black sometimes, it's a bug I think maybe.
    this.ctx.strokeStyle = this.state.selection;

    const rect = this.canvasRef.current.getBoundingClientRect();
    const x = e.clientX - rect.left;
    const y = e.clientY - rect.top;

    if (this.lastX !== null && this.lastY !== null) {
      this.ctx.moveTo(this.lastX, this.lastY);
      this.ctx.lineTo(x, y);
      this.ctx.stroke();
      this.currentLine.push([
        this.lastX,
        this.lastY,
        x,
        y,
        this.state.selection,
      ]);
    }

    this.lastX = x;
    this.lastY = y;
  };

  handleMouseUp = () => {
    this.isPainting = false;
    this.lineStack.push([...this.currentLine]);
    this.currentLine = [];
    this.ctx.beginPath();
  };

  handleSelectionChange = () => {
    const { selection } = this.props;

    if (selection === 'clear') {
      this.ctx.clearRect(
        0,
        0,
        this.canvasRef.current.width,
        this.canvasRef.current.height
      );
      this.ctx.drawImage(
        this.img,
        0,
        0,
        this.canvasRef.current.width,
        this.canvasRef.current.height
      );

      this.lineStack = [];
      return;
    }

    if (selection === 'undo') {
      if (this.lineStack.length === 0) {
        return;
      }
      const line = this.lineStack[this.lineStack.length - 1];

       // selects last color before line is yeeted, this is buggy sometimes.
      const prevColor = line[0][4];
      this.lineStack.pop();

      this.ctx.clearRect(
        0,
        0,
        this.canvasRef.current.width,
        this.canvasRef.current.height
      );
      this.ctx.drawImage(
        this.img,
        0,
        0,
        this.canvasRef.current.width,
        this.canvasRef.current.height
      );
      this.ctx.globalCompositeOperation = 'source-over';

      this.lineStack.forEach((currentLine) => {
        currentLine.forEach(([lastX, lastY, x, y, colorSelection]) => {
          this.ctx.strokeStyle = colorSelection;
          this.ctx.beginPath();
          this.ctx.moveTo(lastX, lastY);
          this.ctx.lineTo(x, y);
          this.ctx.stroke();
        });
      });

      this.setState({ selection: prevColor });
      return;
    }

  if (selection === 'export') {
    const svgData = this.convertToSVG();
    this.props.onImageExport(svgData);
    return;
  }

    this.setState({ selection: selection });
  };

  componentDidUpdate(prevProps) {
    if (prevProps.selection !== this.props.selection) {
      this.handleSelectionChange();
    }
  }

  drawCanvas() {
    this.img.onload = () => {
        // this onload may or may not be causing problems.
      this.ctx.drawImage(
        this.img,
        0,
        0,
        this.canvasRef.current.width,
        this.canvasRef.current.height
      );
    };
  }

  convertToSVG() {
    const svg = document.createElementNS('http://www.w3.org/2000/svg', 'svg');
    svg.setAttribute('xmlns', 'http://www.w3.org/2000/svg');
    svg.setAttribute('width', this.canvasRef.current.width);
    svg.setAttribute('height', this.canvasRef.current.height);
  
    const lines = this.lineStack.flat();
    lines.forEach(([lastX, lastY, x, y, colorSelection]) => {
      const line = document.createElementNS('http://www.w3.org/2000/svg', 'line');
      line.setAttribute('x1', lastX);
      line.setAttribute('y1', lastY);
      line.setAttribute('x2', x);
      line.setAttribute('y2', y);
      line.setAttribute('stroke', colorSelection);
      line.setAttribute('stroke-width', '4');
      line.setAttribute('stroke-linecap', 'round');
      svg.appendChild(line);
    });
  
    const serializer = new XMLSerializer();
    const serializedSvg = serializer.serializeToString(svg);
    const base64Svg = btoa(serializedSvg);
    const dataUrl = `data:image/svg+xml;base64,${base64Svg}`;
  
    return dataUrl;
  }

  render() {
    return (
      <canvas
        ref={this.canvasRef}
        style={{
          height: '100%', // causes discrepency between mouse and drawing line, fix later.
          width: '100%',
        }}
        width={650}
        height={590}
      />
    );
  }
}
