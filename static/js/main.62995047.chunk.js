(this.webpackJsonppanel=this.webpackJsonppanel||[]).push([[0],{20:function(t,e,n){},25:function(t,e,n){"use strict";n.r(e);var c=n(3),a=n.n(c),o=n(15),i=n.n(o),s=(n(20),n(8)),r=n(4),j=n(6),b=n(5),u=n(1),l=function(t){for(var e=t.width,n=t.qty,c=[],a=[],o=0;o<n/e;o++)c.push(Object(u.jsx)(b.c,{strokeWidth:.01,stroke:"black",points:[o*e,0,o*e,n]})),a.push(Object(u.jsx)(b.c,{strokeWidth:.01,stroke:"black",points:[0,o*e,n,o*e]}));return Object(u.jsxs)(b.b,{children:[c,a]})},p=function(){var t=a.a.useState([{name:"\u0414\u0440\u043e\u043d 1",color:"#000",points:[]},{name:"\u0414\u0440\u043e\u043d 2",color:"#F00",points:[]},{name:"\u0414\u0440\u043e\u043d 3",color:"#00F",points:[]}]),e=Object(j.a)(t,2),n=e[0],o=e[1],i=a.a.useState(0),p=Object(j.a)(i,2),O=p[0],d=p[1],x=a.a.useState(""),h=Object(j.a)(x,2),f=h[0],v=h[1],y=a.a.useState(""),m=Object(j.a)(y,2),g=m[0],k=m[1],N=a.a.useState(""),F=Object(j.a)(N,2),S=F[0],C=F[1],w=a.a.useState(""),P=Object(j.a)(w,2),W=P[0],q=P[1],E=function(t,e){if(!Number.isNaN(t)&&!Number.isNaN(e)){var c=Object(r.a)(n);c[O]=Object(s.a)(Object(s.a)({},c[O]),{},{points:[].concat(Object(r.a)(c[O].points),[{x:t,y:e}])}),o(c)}};Object(c.useEffect)((function(){C(n.map((function(t){var e=(void 0!==t.endPoint?[].concat(Object(r.a)(t.points),[t.endPoint]):t.points).map((function(t){return"{".concat(t.x,", ").concat(t.y,", ").concat(W,"}")})).join(",\n");return"code\n".concat(e,"\ncodeend")})).join("\n\n\n\n"))}),[W,n]);return Object(u.jsxs)(u.Fragment,{children:[Object(u.jsxs)("div",{style:{position:"absolute",right:0,zIndex:1e7},children:[Object(u.jsx)("select",{value:O,onChange:function(t){d(parseFloat(t.target.value))},children:n.map((function(t,e){return Object(u.jsx)("option",{value:e,children:t.name},e)}))}),Object(u.jsx)("br",{}),Object(u.jsx)("input",{type:"text",value:f,onChange:function(t){v(t.target.value)}}),Object(u.jsx)("br",{}),Object(u.jsx)("input",{type:"text",value:g,onChange:function(t){k(t.target.value)}}),Object(u.jsx)("br",{}),Object(u.jsx)("button",{type:"button",onClick:function(){return E(parseFloat(f),parseFloat(g))},children:"add"}),Object(u.jsx)("button",{type:"button",onClick:function(){return function(t,e){if(!Number.isNaN(t)&&!Number.isNaN(e)){var c=Object(r.a)(n);c[O]=Object(s.a)(Object(s.a)({},c[O]),{},{endPoint:{x:t,y:e}}),o(c)}}(parseFloat(f),parseFloat(g))},children:"end point"}),Object(u.jsx)("button",{type:"button",onClick:function(){!function(){var t=Object(r.a)(n);t[O]=Object(s.a)(Object(s.a)({},t[O]),{},{points:Object(r.a)(t[O].points.slice(0,t[O].points.length-1))}),o(t)}()},children:"delete"}),Object(u.jsx)("br",{}),Object(u.jsx)("input",{type:"text",value:W,onChange:function(t){q(t.target.value)}}),Object(u.jsx)("br",{}),Object(u.jsx)("textarea",{value:S})]}),Object(u.jsxs)(b.d,{style:{margin:"10px"},width:1e3,height:1e3,scale:{x:100,y:100},onClick:function(t){E(t.evt.layerX/100,t.evt.layerY/100)},children:[Object(u.jsx)(l,{width:1,qty:10}),Object(u.jsx)(b.b,{children:n.map((function(t){return(void 0!==t.endPoint?[].concat(Object(r.a)(t.points),[t.endPoint]):t.points).map((function(e,n){return Object(u.jsxs)(u.Fragment,{children:[Object(u.jsx)(b.a,{id:n.toString(),x:e.x,y:e.y,radius:.1,fill:t.color},n.toString()),n>0&&Object(u.jsx)(b.c,{points:[t.points[n-1].x,t.points[n-1].y,e.x,e.y],strokeWidth:.05,stroke:t.color})]})}))}))})]})]})};i.a.render(Object(u.jsx)(a.a.StrictMode,{children:Object(u.jsx)(p,{})}),document.getElementById("root"))}},[[25,1,2]]]);
//# sourceMappingURL=main.62995047.chunk.js.map