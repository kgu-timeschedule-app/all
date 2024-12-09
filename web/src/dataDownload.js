import "./App.css";
import React, { useMemo, useEffect } from "react";
import axios from "axios";

export default function DataDownload(props) {
  let result = useMemo(() => {
    let result = {};
  axios
    .get("https://api.syllabus.tanemura.dev/all.json") //リクエストを飛ばすpath
    .then((response) => {
      Object.assign(result, response.data);
    })
    .catch(() => {
      console.log("通信に失敗しました");
    });
    return (result);
  },[]);
  useEffect(() => props.data(result), [props, result]);
  return <div></div>;
}
