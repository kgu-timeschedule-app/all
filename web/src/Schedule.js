import "./App.css";
import Typography from "@material-ui/core/Typography";
import { Box } from "@material-ui/core";
import Card from "@material-ui/core/Card";
import CardActions from "@material-ui/core/CardActions";
import CardContent from "@material-ui/core/CardContent";
import Button from "@material-ui/core/Button";
import { useHistory } from "react-router-dom";
import { db } from "./firebasec_conf";
import React, { useEffect, useState } from "react";

export default function Schedule(props) {
  const history = useHistory();
  const [data, setData] = useState([]);
  const [first_message, setMessage] = useState("");
  const [userid, setUserId] = useState("");
  let esc = ["春学期", "秋学期"];
  useEffect(() => {
    setUserId(props.user.uid);
    db.collection("users")
      .doc(userid)
      .get()
      .then((doc) => {
        if (doc.exists) {
          setData(Object.keys(doc.data()));
          setMessage(
            "以下の授業の時間割を確認することができます。時間割の登録は授業をこのシラバスで検索していただき、各教科の詳細ページの画面右下のsubscribeボタンで登録することができます。また、間違えて登録した場合は各教科の詳細ページの画面右下のDeleteボタンを押してください。"
          );
        } else {
          let u = db.collection("users").doc(userid);
          u.set({ 202201: [] }, { merge: true });
          u.set({ 202202: [] }, { merge: true });
          setData(["202201", "202202"]);
          setMessage(
            "登録いただき、ありがとうございます。以下の授業の時間割を確認することができます。時間割の登録は授業をこのシラバスで検索していただき、各教科の詳細ページの画面右下のsubscribeボタンで登録することができます。また、間違えて登録した場合は各教科の詳細ページの画面右下のDeleteボタンを押してください。"
          );
        }
        // });
      });
  }, [setUserId]);
  // const handleMake = () => {
  //   history.push({
  //     pathname: "/schedulemake",
  //   });
  // };

  const seeMore = (name) => {
    history.push({
      pathname: `/schedule/${name}`,
    });
  };
  return (
    <div>
      <Box mt={4} mx={4}>
        <Typography variant="h5" component="h2">
          {first_message}
        </Typography>
      </Box>
      <Box mx={4} mt={4}>
        {/* <Button onClick={handleMake}>新規作成</Button> */}
        {data.map((name, i) => (
          <Box my={4}>
            <Card>
              <CardContent>
                <Typography variant="h5" component="h2">
                  {name.slice(0, -2) +
                    "年度" +
                    esc[parseInt(name.slice(-1)) - 1]}
                </Typography>
              </CardContent>
              <CardActions>
                <Button key={i} size="small" onClick={() => seeMore(name)}>
                  時間割を見る
                </Button>
              </CardActions>
            </Card>
          </Box>
        ))}
      </Box>
    </div>
  );
}
