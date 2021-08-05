
import React, { useEffect } from "react";
import Prism from "prismjs";
import "prismjs/themes/prism-solarizedlight.css";
import 'prismjs/components/prism-clike';
import 'prismjs/components/prism-yaml';
import 'prismjs/components/prism-python';
import 'prismjs/components/prism-bash';
import 'prismjs/components/prism-shell-session';
import "./styles.css";


export default function Code({ code, language }) {
  useEffect(() => {
    Prism.highlightAll();
  }, []);
  return (
    <div className="Code">
      <pre>
        <code className={`language-${language}`}>{code}</code>
      </pre>
    </div>
  );
}
