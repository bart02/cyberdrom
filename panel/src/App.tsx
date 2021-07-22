import React from 'react';
import {
  Stage, Layer, Star, Line,
} from 'react-konva';
import Konva from 'konva';

export interface Point {
  x: number,
  y: number,
}

export interface Path {
  name: string,
  color: string,
  points: Point[]
}

const App = () => {
  const [paths, setPaths] = React.useState<Path[]>([
    { name: 'Дрон 1', color: '#000', points: [] },
    { name: 'Дрон 2', color: '#F00', points: [] },
    { name: 'Дрон 3', color: '#00F', points: [] },
  ]);
  const [curPath, setCurPath] = React.useState(0);
  const [formX, setFormX] = React.useState('');
  const [formY, setFormY] = React.useState('');

  const addPoint = (x: number, y: number) => {
    const cpaths = [...paths];
    cpaths[curPath] = { ...cpaths[curPath], points: [...cpaths[curPath].points, { x, y }] };

    setPaths(cpaths);
  };

  const addPointEvent = (e: Konva.KonvaEventObject<MouseEvent>) => {
    addPoint(e.evt.x / 100, e.evt.y / 100);
  };

  const download = () => {
    // eslint-disable-next-line array-callback-return
    paths.map((path) => {
      const kjfdsbgvhrjfdksl = path.points.map((point) => (
        `{${point.x}, ${point.y}, 2.0}`
      )).join('\n');
      console.log(kjfdsbgvhrjfdksl);
    });
  };

  return (
    <>
      <div style={{ position: 'absolute', right: 0, zIndex: 10000000 }}>
        <select value={curPath} onChange={(e) => { setCurPath(parseInt(e.target.value, 10)); }}>
          {paths.map((path, i) => (
            // eslint-disable-next-line react/no-array-index-key
            <option key={i} value={i}>{path.name}</option>
          ))}
        </select>
        <br />
        <input type="text" value={formX} onChange={((e) => { setFormX(e.target.value); })} />
        <br />
        <input type="text" value={formY} onChange={((e) => { setFormY(e.target.value); })} />
        <br />
        <button type="button" onClick={() => addPoint(parseInt(formX, 10), parseInt(formY, 10))}>add</button>
        <br />
        <button type="button" onClick={() => { download(); }}>download</button>
      </div>
      <Stage width={1000} height={1000} scale={{ x: 100, y: 100 }} onClick={addPointEvent}>
        <Layer>
          {paths.map((path) => (
            path.points.map((star, i) => (
              <>
                <Star
                  key={i.toString()}
                  id={i.toString()}
                  x={star.x}
                  y={star.y}
                  numPoints={5}
                  innerRadius={0.1}
                  outerRadius={0.2}
                  fill={path.color}
                />
                {i > 0 && (
                <Line
                  points={[path.points[i - 1].x, path.points[i - 1].y, star.x, star.y]}
                  strokeWidth={0.05}
                  stroke={path.color}
                />
                )}
              </>
            ))
          ))}
        </Layer>
      </Stage>
    </>
  );
};

export default App;
