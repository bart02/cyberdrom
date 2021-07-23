import React from 'react';
import { Layer, Line } from 'react-konva';

// eslint-disable-next-line react/prop-types
const Net: React.FC<{ width: number; qty: number }> = ({ width, qty }) => {
  const linesA = [];
  const linesB = [];

  // eslint-disable-next-line no-plusplus
  for (let i = 0; i < qty / width; i++) {
    linesA.push(
      <Line
        strokeWidth={0.01}
        stroke="black"
        points={[i * width, 0, i * width, qty]}
      />,
    );

    linesB.push(
      <Line
        strokeWidth={0.01}
        stroke="black"
        points={[0, i * width, qty, i * width]}
      />,
    );
  }

  return (
    <Layer>
      {linesA}
      {linesB}
    </Layer>
  );
};

export default Net;
