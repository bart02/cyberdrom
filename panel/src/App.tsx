import React, { useEffect } from 'react';
import {
  Stage, Layer, Line, Circle,
} from 'react-konva';
import Konva from 'konva';
import Net from './Net';

export interface Point {
  x: number,
  y: number,
}

export interface Path {
  name: string,
  color: string,
  points: Point[],
  endPoint?: Point
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
  const [code, setCode] = React.useState('');
  const [height, setHeight] = React.useState('');

  const addPoint = (x: number, y: number) => {
    if (!Number.isNaN(x) && !Number.isNaN(y)) {
      const cpaths = [...paths];
      cpaths[curPath] = { ...cpaths[curPath], points: [...cpaths[curPath].points, { x, y }] };

      setPaths(cpaths);
    }
  };

  const setEndpoint = (x: number, y: number) => {
    if (!Number.isNaN(x) && !Number.isNaN(y)) {
      const cpaths = [...paths];
      cpaths[curPath] = { ...cpaths[curPath], endPoint: { x, y } };

      setPaths(cpaths);
    }
  };

  const addPointEvent = (e: Konva.KonvaEventObject<MouseEvent>) => {
    // @ts-ignore
    addPoint(e.evt.layerX / 100, e.evt.layerY / 100);
  };

  useEffect(() => {
    // eslint-disable-next-line array-callback-return
    setCode(paths.map((path) => {
      // eslint-disable-next-line max-len
      const coordsArray = (path.endPoint !== undefined ? [...path.points, path.endPoint] : path.points)
        .map((point) => (
          `{${point.x}, ${point.y}, ${height}}`
        )).join(',\n');

      return `code
${coordsArray}
codeend`;
    }).join('\n\n\n\n'));
  }, [height, paths]);

  const delPoint = () => {
    const cpaths = [...paths];
    cpaths[curPath] = {
      ...cpaths[curPath],
      points: [...cpaths[curPath].points.slice(0, cpaths[curPath].points.length - 1)],
    };

    setPaths(cpaths);
  };

  return (
    <>
      <div style={{ position: 'absolute', right: 0, zIndex: 10000000 }}>
        <select value={curPath} onChange={(e) => { setCurPath(parseFloat(e.target.value)); }}>
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
        <button type="button" onClick={() => addPoint(parseFloat(formX), parseFloat(formY))}>add</button>
        <button type="button" onClick={() => setEndpoint(parseFloat(formX), parseFloat(formY))}>end point</button>
        <button type="button" onClick={() => { delPoint(); }}>delete</button>
        <br />
        <input type="text" value={height} onChange={((e) => { setHeight(e.target.value); })} />
        <br />
        <textarea value={code} />
      </div>

      <Stage style={{ margin: '10px' }} width={1000} height={1000} scale={{ x: 100, y: 100 }} onClick={addPointEvent}>
        <Net width={1} qty={10} />
        <Layer>
          {paths.map((path) => (
            (path.endPoint !== undefined ? [...path.points, path.endPoint] : path.points)
              .map((star, i) => (
                <>
                  <Circle
                    key={i.toString()}
                    id={i.toString()}
                    x={star.x}
                    y={star.y}
                    radius={0.1}
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
