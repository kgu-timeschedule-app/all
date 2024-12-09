import "./App.css";
import Typography from "@material-ui/core/Typography";
import { Box } from "@material-ui/core";
import { makeStyles } from "@material-ui/core/styles";
import Grid from "@material-ui/core/Grid";
import React, { useEffect, useState } from "react";
import { useHistory, useLocation } from "react-router-dom";
import Table from "react-bootstrap/Table";
import TableCell from "@material-ui/core/TableCell";
import TableContainer from "@material-ui/core/TableContainer";
import TableHead from "@material-ui/core/TableHead";
import TableRow from "@material-ui/core/TableRow";
import Paper from "@material-ui/core/Paper";
import firebase, { db } from "./firebasec_conf";
import axios from "axios";
import Link from "@material-ui/core/Link";

const useStyles = makeStyles((theme) => ({
  time: {
    display: "block",
    width: "100%",
    height: "100%",
  },
  exam: {
    color: "blue",
  },
}));

export default function ShowSchedule(props) {
  const classes = useStyles();
  const location = useLocation();
  const id = location.pathname.replace("/schedule/", "");
  let [timelist, setTimelist] = useState(Array(55).fill(""));
  let uid;
  let data;
  let [culcgrade, setCulcgrade] = useState(0);
  let [texts, setTests] = useState([]);
  let [subjects, setSubjects] = useState([]);
  let [reference, setReference] = useState([]);
  let [grading, setGrading] = useState([]);
  let [test, setTest] = useState(0);
  const history = useHistory();


  let campas_data = [
    "西宮上ケ原キャンパス／Nishinomiya Uegahara Campus",
    "神戸三田キャンパス／Kobe Sanda Campus",
    "大阪梅田キャンパス／Osaka Umeda Campus",
    "西宮市大学交流センター／Nishinomiya City Intercollegiate Center",
    "西宮聖和キャンパス／Nishinomiya Seiwa Campus",
    "オンライン／Online",
    "東京丸の内キャンパス／Tokyo Marunouchi Campus",
    "西宮北口キャンパス／Nishinomiya Kitaguchi Campus",
  ];
  let ad_data = [
    "神学部／School of Theology",
    "文学部／School of Humanities",
    "社会学部／School of Sociology",
    "法学部／School of Law and Politics",
    "経済学部／School of Economics",
    "商学部／School of Business Administration",
    "理工学部／School of Science and Technology",
    "総合政策学部／School of Policy Studies",
    "人間福祉学部／School of Human Welfare Studies",
    "教育学部／School of Education",
    "国際学部/International Studies／School of International Studies",
    "理学部／School of Science",
    "工学部／School of Engineering",
    "生命環境学部／School of Biological and Environmental Sciences",
    "建築学部／School of Architecture",
    "使用しない（カリキュラム設定用　非正規　大学",
    "スポーツ科学・健康科学教育プログラム室／Sports and Health Sciences Program Office",
    "共通教育センター／Center for Common Educational Programs",
    "キャリアセンター／Center for Career Planning and Placement",
    "共通教育センター（情報科学科目）／Center for Common Educational Programs (Information Science Courses)",
    "言語教育研究センター／Language Center",
    "国際教育・協力センター（CIEC　JEASP）／Center for International Education and Cooperation (JEASP)",
    "教職教育研究センター（資格）／Research Center for Teacher Development (for Certifications)",
    "教職教育研究センター（教職専門）／Research Center for Teacher Development (for Special Studies)",
    "国際教育・協力センター/CIEC／Center for International Education and Cooperation",
    "キリスト教と文化研究センター／Research Center for Christianity and Culture",
    "日本語教育センター／Center for Japanese Language Education",
    "ハンズオン・ラーニングセンター／Center for Hands-on Learning Programs",
    "国連・外交統括センター／Integrated Center for UN and Foreign Affairs Studies",
    "神学研究科前期／Graduate School of Theology Master&#39;s Course",
    "文学研究科前期／Graduate School of Humanities Master&#39;s Course",
    "社会学研究科前期／Graduate School of Sociology Master&#39;s Course",
    "法学研究科前期／Graduate School of Law and Politics Master&#39;s Course",
    "経済学研究科前期／Graduate School of Economics Master&#39;s Course",
    "商学研究科前期／Graduate School of Business Administration Master&#39;s Course",
    "理工学研究科前期／Graduate School of Science and Technology Master&#39;s Course",
    "総合政策研究科前期／Graduate School of Policy Studies Master&#39;s Course",
    "言語コミュニケーション前期／Graduate School of Language, Communication, and Culture Master&#39;s Course",
    "人間福祉研究科前期／Graduate School of Human Welfare Studies Master&#39;s Course",
    "教育学研究科前期／Graduate School of Education Master&#39;s Course",
    "理工学研究科修士／Graduate School of Science and Technology Master&#39;s Course",
    "国際学研究科前期／Graduate School of International Studies Master&#39;s Course",
    "大学院共通科目・認定科目前期／Graduate School of Master&#39;s Course (Certified)",
    "神学研究科後期／Graduate School of Theology Doctoral Course",
    "文学研究科後期／Graduate School of Humanities Doctoral Course",
    "社会学研究科後期／Graduate School of Sociology Doctoral Course",
    "法学研究科後期／Graduate School of Law and Politics Doctoral Course",
    "経済学研究科後期／Graduate School of Economics Doctoral Course",
    "商学研究科後期／Graduate School of Business Administration Doctoral Course",
    "理工学研究科後期／Graduate School of Science and Technology Doctoral Course",
    "総合政策研究科後期／Graduate School of Policy Studies Doctoral Course",
    "言語コミュニケーション後期／Graduate School of Language, Communication, and Culture Doctoral Course",
    "人間福祉研究科後期／Graduate School of Human Welfare Studies Doctoral Course",
    "教育学研究科後期／Graduate School of Education Doctoral Course",
    "経営戦略研究科後期／Graduate School of Institute of Business and Accounting Doctoral Course",
    "国際学研究科後期／Graduate School of International Studies Doctoral Course",
    "大学院共通科目・認定科目後期／Graduate School of Doctoral Course (Certified)",
    "司法研究科／Law School",
    "経営戦略研究科/IBA／Institute of Business and Accounting",
    "使用しない（カリキュラム設定用　非正規　大学院）",
  ];
  let study = [
    "対面授業/Face to face format",
    "同時双方向型オンライン授業/Online format: Simultaneous and two-way",
    "オンデマンドＡ型オンライン授業(時間割あり)/On-demand A(with timetable)",
    "オンデマンドＢ型オンライン授業(時間割なし)/On-demand B(w/o timetable)",
    "オンライン受講不可/Online attendance is NOT permitted."
  ]  
  // let result = [];
  function hankaku2Zenkaku(str) {
    return str.replace(/[Ａ-Ｚａ-ｚ０-９]/g, function (s) {
      return String.fromCharCode(s.charCodeAt(0) - 0xfee0);
    });
  }

  // const handleChange = (event) => {
  //   setState({ ...state, [event.target.name]: event.target.checked });
  // };
  useEffect(() => {
    firebase.auth().onAuthStateChanged((user) => {
      if (user) {
        uid = user.uid;
        db.collection("users")
          .doc(uid)
          .get()
          .then(async (doc) => {
            if (doc.exists) {
              if (data === undefined) {
                let grade1 = 0;
                // console.log(id, doc.data()[id])
                for (let i in doc.data()[id]) {
                  await axios
                    .get(
                      `https://api.syllabus.tanemura.dev/all/${
                        doc.data()[id][i]
                      }.json`
                    ) //リクエストを飛ばすpath
                    // eslint-disable-next-line no-loop-func
                    .then((response) => {
                      if (
                        response.data["【科目ナンバー/Course Number】授業名称"] === undefined
                      ) {
                      response.data["【科目ナンバー/Course Number】授業名称"] = response.data["name"];
                      response.data["管理部署"] = ad_data[response.data["管理部署"]]
                      response.data["開講キャンパス"] = campas_data[response.data["campas"]]
                      response.data["授業形態"] = study[response.data["授業形態"]]
                      response.data["緊急授業形態"] = study[response.data["緊急授業形態"]]
                      response.data["オンライン授業形態"] = study[response.data["オンライン授業形態"]]
                      }
                      let a = 0;
                      let l = 1;
                      let text = texts;
                      let references = reference;
                      let grade_sc = grading;
                      let subject = subjects;
                      subject.push(
                        response.data["【科目ナンバー/Course Number】授業名称"]
                      );
                      setSubjects(subject);
                      while (
                        (Object.keys(response.data["評価"]).indexOf(
                          `教科書Required texts${a}`
                        ) !== -1 ||
                          Object.keys(response.data["評価"]).indexOf(
                            `教科書/Required texts${a}`
                          ) !== -1) &&
                        (response.data["評価"][`教科書Required texts${a}`] !==
                          undefined ||
                          response.data["評価"][
                            `教科書/Required texts${a + 1}`
                          ] !== undefined)
                      ) {
                        text.push([
                          response.data[
                            "【科目ナンバー/Course Number】授業名称"
                          ],
                          Object.keys(response.data["評価"]).indexOf(
                            `教科書Required texts${a}`
                          ) !== -1
                            ? response.data["評価"][`教科書Required texts${a}`]
                            : response.data["評価"][
                                `教科書/Required texts${a + 1}`
                              ],
                        ]);

                        a++;
                      }
                      setTests(text);
                      a = 0;

                      // console.log(Object.keys(response.data["評価"]).indexOf(`参考文献・資料Reference books${a}`), response.data["評価"][`参考文献・資料Reference books${a}`]);
                      // 参考書
                      while (
                        (Object.keys(response.data["評価"]).indexOf(
                          `参考文献・資料Reference books${a}`
                        ) !== -1 ||
                          Object.keys(response.data["評価"]).indexOf(
                            `参考書/Reference books${a}`
                          ) !== -1) &&
                        (response.data["評価"][
                          `参考文献・資料Reference books${a}`
                        ] !== undefined ||
                          response.data["評価"][
                            `参考書/Reference books${a + 1}`
                          ] !== undefined)
                      ) {
                        references.push([
                          response.data[
                            "【科目ナンバー/Course Number】授業名称"
                          ],
                          Object.keys(response.data["評価"]).indexOf(
                            `参考文献・資料Reference books${a}`
                          ) !== -1
                            ? response.data["評価"][
                                `参考文献・資料Reference books${a}`
                              ]
                            : response.data["評価"][
                                `参考書/Reference books${a + 1}`
                              ],
                        ]);

                        a++;
                      }
                      a = 1;
                      // console.log(references)
                      setReference(references);
                      grade_sc.push(
                        response.data["【科目ナンバー/Course Number】授業名称"]
                      );
                      while (
                        response.data["評価"][`成績評価Grading${a}`] !==
                          undefined &&
                        response.data["評価"][`成績評価Grading${a}`][0]
                          .length !== 1
                      ) {
                        grade_sc.push(
                          response.data["評価"][`成績評価Grading${a}`]
                        );
                        a++;
                        setGrading(grade_sc);
                      }
                      let ref = timelist;
                      while (response.data["評価"][`項番No.${l}`]) {
                        // let ref = timelist;
                        let week = response.data["評価"][`項番No.${l}`][2]
                          .replaceAll("曜", "")
                          .replaceAll("時限", "")
                          .split("／")[0]
                          .split("");
                        week[0] = week[0]
                          .replaceAll("日", "0")
                          .replaceAll("月", "1")
                          .replaceAll("火", "2")
                          .replaceAll("水", "3")
                          .replaceAll("木", "4")
                          .replaceAll("金", "5")
                          .replaceAll("土", "6");

                        ref[
                          parseInt(week[0]) +
                            parseInt(hankaku2Zenkaku(week[1]) - 1) * 7
                        ] = [
                          response.data[
                            "【科目ナンバー/Course Number】授業名称"
                          ],
                          response.data["評価"][`項番No.${l}`][4],
                          doc.data()[id][i],
                        ];
                        l++;
                      }
                      setTimelist(ref);
                      grade1 += parseInt(response.data["単位数"]);
                    });
                }
                // console.log(grade1);
                setCulcgrade(grade1);
              }
            }
          });
        // .catch(() => {
        //   console.log("通信に失敗しました");
        // });
      } else {
        console.log("No such document!");
      }
    });
  }, [culcgrade, reference, texts]);
  // culcgrade timelist, culcgrade, texts, subjects, grading
  let esc = ["春学期", "秋学期"];

  const tosearch = (values, index, value) => {
    if (value) {
      history.push({
        pathname: `/subject/${value[2]}`,
      });
    }
  };
  let i = 0;
  function convertToIsbn10(isbn13) {
    const sum = isbn13.split('').slice(3, 12).reduce((acc, c, i) => {
        return acc + (c[0] - '0') * (10 - i);
    }, 0);
    const checkDigit = 11 - sum % 11;
    const isbn10 = isbn13.substring(3, 12) + checkDigit.toString();
    return isbn10;
}
let testnum = 0;
  return (
    <div>
      <Box my={4} mx={{ xs: 0, md: 4 }}>
        <Typography variant="h4" component="h4">
          {id.slice(0, -2) +
            "年度" +
            esc[parseInt(id.slice(-1)) - 1] +
            "時間割"}
        </Typography>
        <Typography variant="body1" component="h6">
          {
            "登録された時間割を表示します。表示には少し時間がかかることがあります。画面下部に教科書、テスト一覧が表示されます。集中科目は時間割には表示されません。科目がない場合は左下フィードバックよりフィードバックをお寄せください。このページを印刷(Ctrl + P)して教科書販売時に持っていくことができます。"
          }
        </Typography>
      </Box>
      {/* <Box my={4} mx={4}>
        <Typography variant="body1" component="h6">
          消す？
        </Typography>
        <Switch
          checked={state.editor}
          onChange={handleChange}
          name="editor"
          color="primary"
          inputProps={{ "aria-label": "primary checkbox" }}
        />
      </Box> */}
      <link
        rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css"
        integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l"
        crossorigin="anonymous"
      />
      <Table striped bordered hover responsive>
        <thead>
          <tr>
            <th>#</th>
            <th>日曜日</th>
            <th>月曜日</th>
            <th>火曜日</th>
            <th>水曜日</th>
            <th>木曜日</th>
            <th>金曜日</th>
            <th>土曜日</th>
          </tr>
        </thead>
        <tbody>
          {[0, 1, 2, 3, 4, 5, 6].map((values) => (
            <tr>
              <td>{values + 1}</td>
              {timelist
                .slice(values * 7, (values + 1) * 7)
                .map((value, index) => {
                  if (value && value[0] && value[0].indexOf("／") !== -1) {
                    return (
                      <td>
                        <Link
                          className={classes.time}
                          color="secondary"
                          onClick={() => {
                            tosearch(values, index, value);
                          }}
                        >
                          {value[0].split("／")[0]}
                          <br />
                          {value[1]}
                        </Link>
                      </td>
                    );
                  } else {
                    return (
                      <td>
                        <Link
                          className={classes.time}
                          color="secondary"
                          onClick={() => {
                            tosearch(values, index, value);
                          }}
                        ></Link>
                      </td>
                    );
                  }
                })}
            </tr>
          ))}
        </tbody>
      </Table>
      <Box my={4} mx={4}>
        <Typography
          className="mr-4 ml-2"
          variant="h6"
          component="h5"
          display="inline"
        >
          総合単位数
        </Typography>
        <Typography variant="h3" component="h2" display="inline">
          {culcgrade}
        </Typography>
        <Typography
          className="mr-4 ml-5"
          variant="h6"
          component="h5"
          display="inline"
        >
          定期試験数
        </Typography>
        <Typography variant="h3" component="h2" display="inline">
          {test}
        </Typography>
        <Typography
          className="mr-4 ml-2"
          variant="h6"
          component="h5"
          display="inline"
        >
          教科
        </Typography>
        <Box my={4}>
          amazonのリンクがエラーになっている場合はamazonで販売されていない商品です。大学生協でご購入ください。
          <Grid
            container
            direction="row"
            justifyContent="flex-start"
            alignItems="center"
            spacing={0}
          >
            <Grid item xs={12} md={1}>
              <Typography variant="h6" component="h5">
                教科書
              </Typography>
            </Grid>
            <Grid item xs={12} md={11}>
              <TableContainer component={Paper}>
                <Table className={classes.table} aria-label="simple table">
                  <TableHead>
                    <TableRow>
                      <TableCell>教科</TableCell>
                      <TableCell>著者名</TableCell>
                      <TableCell align="left">タイトル</TableCell>
                      <TableCell align="left">発行所</TableCell>
                      <TableCell align="left">出版年</TableCell>
                      <TableCell align="left">ISBN</TableCell>
                      <TableCell align="left">Amazon</TableCell>
                    </TableRow>
                  </TableHead>
                  {texts.map((values, i) => {
                    if (values !== undefined) {
                      if (values[1][0].length === 1)
                        return (
                          <TableRow>
                            <TableCell align="left">{values[0]}</TableCell>
                            <TableCell align="left" colSpan={6}>
                              {values[1]}
                            </TableCell>
                          </TableRow>
                        );
                      else
                        return (
                          <TableRow>
                            <TableCell align="left">{values[0]}</TableCell>
                            <TableCell align="left">{values[1][0]}</TableCell>
                            <TableCell align="left">{values[1][1]}</TableCell>
                            <TableCell align="left">{values[1][2]}</TableCell>
                            <TableCell align="left">{values[1][3]}</TableCell>
                            <TableCell align="left">{values[1][4]}</TableCell>
                            <TableCell align="left">
                              <Link
                              target="_blank"
                                href={
                                  values[1][4].replaceAll("-","").length === 13 ? "https://www.amazon.co.jp/gp/product/" + convertToIsbn10(values[1][4].replaceAll("-",""))  +
                                  "?pf_rd_r=0V34BQC9CC75KKFHJYTY&pf_rd_p=3a18ae70-29cd-40df-b252-334783771910&pd_rd_r=670d7540-8ef3-42a3-adf8-cd65cf3c44d7&pd_rd_w=xe2JN&pd_rd_wg=WxfEx&linkCode=ll1&tag=tane38-22&linkId=fa67bfe005978bc7f829301e7265fc49&language=ja_JP&ref_=as_li_ss_tl"
                            :  "https://www.amazon.co.jp/gp/product/" + values[1][4].replaceAll("-","") +
                                  "?pf_rd_r=0V34BQC9CC75KKFHJYTY&pf_rd_p=3a18ae70-29cd-40df-b252-334783771910&pd_rd_r=670d7540-8ef3-42a3-adf8-cd65cf3c44d7&pd_rd_w=xe2JN&pd_rd_wg=WxfEx&linkCode=ll1&tag=tane38-22&linkId=fa67bfe005978bc7f829301e7265fc49&language=ja_JP&ref_=as_li_ss_tl"
                                }
                                color="blue"
                              >
                                Amazon
                              </Link>
                            </TableCell>
                          </TableRow>
                        );
                    }
                    return null;
                  })}
                </Table>
              </TableContainer>
            </Grid>
          </Grid>
        </Box>
        <Box my={4}>
          <Grid
            container
            direction="row"
            justifyContent="flex-start"
            alignItems="center"
            spacing={0}
          >
            <Grid item xs={12} md={1}>
              <Typography variant="h6" component="h5">
                参考書
              </Typography>
            </Grid>
            <Grid item xs={12} md={11}>
              <TableContainer component={Paper}>
                <Table className={classes.table} aria-label="simple table">
                  <TableHead>
                    <TableRow>
                      <TableCell>教科</TableCell>
                      <TableCell>著者名</TableCell>
                      <TableCell align="left">タイトル</TableCell>
                      <TableCell align="left">発行所</TableCell>
                      <TableCell align="left">出版年</TableCell>
                      <TableCell align="left">ISBN</TableCell>
                      <TableCell align="left">Amazon</TableCell>
                    </TableRow>
                  </TableHead>
                  {reference.map((values, i) => {
                    if (values !== undefined) {
                      if (values[1][0].length === 1)
                        return (
                          <TableRow>
                            <TableCell align="left">{values[0]}</TableCell>
                            <TableCell align="left" colSpan={6}>
                              {values[1]}
                            </TableCell>
                          </TableRow>
                        );
                      else
                        return (
                          <TableRow>
                            <TableCell align="left">{values[0]}</TableCell>
                            <TableCell align="left">{values[1][0]}</TableCell>
                            <TableCell align="left">{values[1][1]}</TableCell>
                            <TableCell align="left">{values[1][2]}</TableCell>
                            <TableCell align="left">{values[1][3]}</TableCell>
                            <TableCell align="left">{values[1][4]}</TableCell>
                            <TableCell align="left">
                              <Link
                              target="_blank"
                                href={values[1][4].replaceAll("-","").length === 13 ?  "https://www.amazon.co.jp/gp/product/" + convertToIsbn10(values[1][4].replaceAll("-","")) +
                                "?pf_rd_r=0V34BQC9CC75KKFHJYTY&pf_rd_p=3a18ae70-29cd-40df-b252-334783771910&pd_rd_r=670d7540-8ef3-42a3-adf8-cd65cf3c44d7&pd_rd_w=xe2JN&pd_rd_wg=WxfEx&linkCode=ll1&tag=tane38-22&linkId=fa67bfe005978bc7f829301e7265fc49&language=ja_JP&ref_=as_li_ss_tl"
                           :  "https://www.amazon.co.jp/gp/product/" + values[1][4].replaceAll("-","") +
                                  "?pf_rd_r=0V34BQC9CC75KKFHJYTY&pf_rd_p=3a18ae70-29cd-40df-b252-334783771910&pd_rd_r=670d7540-8ef3-42a3-adf8-cd65cf3c44d7&pd_rd_w=xe2JN&pd_rd_wg=WxfEx&linkCode=ll1&tag=tane38-22&linkId=fa67bfe005978bc7f829301e7265fc49&language=ja_JP&ref_=as_li_ss_tl"
                                }
                                color="blue"
                              >
                                Amazon
                              </Link>
                            </TableCell>
                          </TableRow>
                        );
                    }
                    return null;
                  })}
                </Table>
              </TableContainer>
            </Grid>
          </Grid>
        </Box>
        <Box my={4}>
          <Grid
            container
            direction="row"
            justifyContent="flex-start"
            alignItems="center"
            spacing={0}
          >
            <Grid item xs={12} md={1}>
              <Typography variant="h6" component="h5">
                テスト
              </Typography>
            </Grid>
            <Grid item xs={12} md={11}>
              <Grid
                container
                direction="row"
                justifyContent="flex-start"
                alignItems="center"
                spacing={0}
              >
                {grading.map((value, index) => {
                  let result = [];
                  let k = 0;
                  if (value !== undefined){
                  if (value.length === 3 && i !== 1) {
                    //タイトル
                    result.push(<Grid item xs={12} md={6}></Grid>);
                  } else if (i !== 1) {
                    i = 1;
                    result.push(
                      <Grid item xs={12} md={6}>
                        <Box mt={4}>
                          <Typography variant="h6" >
                            {value}
                          </Typography>
                        </Box>
                      </Grid>
                    );
                  } else {
                    i = 0;
                    k = 1;
                  }
                  // console.log(value);
                  if (i === 0 && k === 0) {
                    result.push(
                      <Grid item xs={9} md={3}>
                        <Typography variant="h6" >
                          {value[0].indexOf("／") !== -1
                            ? value[0].split("／")[0]
                            : value[0]}
                        </Typography>
                      </Grid>
                    );
                    result.push(
                      <Grid item xs={3} md={1}>
                        <Typography variant="h6" >
                          {value[1]}
                        </Typography>
                      </Grid>
                    );
                    result.push(
                      <Grid item xs={12} md={2}>
                        <Typography variant="body1" >
                          {value[2]}
                        </Typography>
                      </Grid>
                    );
                  } else if (k === 1) {
                    if (
                      value[0].indexOf("／") !== -1 &&
                      value[0].split("／")[0] === "定期試験"
                    ) {
                      testnum += 1;
                      // console.log(testnum)
                      result.push(
                        <Grid item xs={9} md={3}>
                          <Box mt={4}>
                            <Typography
                              variant="h6"
                              
                              className={classes.exam}
                            >
                              {value[0].split("／")[0]}
                            </Typography>
                          </Box>
                        </Grid>
                      );
                    } else {
                      result.push(
                        <Grid item xs={9} md={3}>
                          <Box mt={4}>
                            <Typography variant="h6" >
                              {value[0].indexOf("／") !== -1
                                ? value[0].split("／")[0]
                                : value[0]}
                            </Typography>
                          </Box>
                        </Grid>
                      );
                    }
                    result.push(
                      <Grid item xs={3} md={1}>
                        <Box mt={4}>
                          <Typography variant="h6" >
                            {value[1]}
                          </Typography>
                        </Box>
                      </Grid>
                    );
                    result.push(
                      <Grid item xs={12} md={2}>
                        <Box mt={4}>
                          <Typography variant="body1" >
                            {value[2]}
                          </Typography>
                        </Box>
                      </Grid>
                    );
                  };
                  return result;
                }
                })
                // useEffect(() => {setTest(testnum)},[]); 
                }
                {useEffect(() => {setTest(testnum)},[testnum, test])}
              </Grid>
            </Grid>
          </Grid>
        </Box>
      </Box>
    </div>
  );
}
