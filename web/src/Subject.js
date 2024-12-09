import "./App.css";
import Typography from "@material-ui/core/Typography";
import { Box } from "@material-ui/core";
import { makeStyles } from "@material-ui/core/styles";
import Breadcrumbs from "@material-ui/core/Breadcrumbs";
import Link from "@material-ui/core/Link";
import Grid from "@material-ui/core/Grid";
import Button from "@material-ui/core/Button";
import Accordion from "@material-ui/core/Accordion";
import AccordionSummary from "@material-ui/core/AccordionSummary";
import AccordionDetails from "@material-ui/core/AccordionDetails";
import ExpandMoreIcon from "@material-ui/icons/ExpandMore";
import Table from "@material-ui/core/Table";
import TableBody from "@material-ui/core/TableBody";
import TableCell from "@material-ui/core/TableCell";
import TableContainer from "@material-ui/core/TableContainer";
import TableHead from "@material-ui/core/TableHead";
import TableRow from "@material-ui/core/TableRow";
import Paper from "@material-ui/core/Paper";
import { useHistory, useLocation } from "react-router-dom";
import axios from "axios";
import React, { useEffect, useState } from "react";
import Skeleton from "@material-ui/lab/Skeleton";
import Subjectcontent from "./Subjectcontent";
import "firebase/auth";
import { rdb } from "./firebasec_conf";
import Alert from "@material-ui/lab/Alert";
import Card from "@material-ui/core/Card";
import { Helmet, HelmetProvider } from "react-helmet-async";
import CardContent from "@material-ui/core/CardContent";
import Dialog from "@material-ui/core/Dialog";
import DialogActions from "@material-ui/core/DialogActions";
import DialogContent from "@material-ui/core/DialogContent";
import DialogContentText from "@material-ui/core/DialogContentText";
import DialogTitle from "@material-ui/core/DialogTitle";
import ThumbsUpDownIcon from "@material-ui/icons/ThumbsUpDown";
import Rating from "@material-ui/lab/Rating";
import StarBorderIcon from "@material-ui/icons/StarBorder";
import TextField from "@material-ui/core/TextField";
import { Bar } from "react-chartjs-2";
import DataDownload from "./dataDownload";
import {
  LineShareButton,
  TwitterShareButton,
  LineIcon,
  TwitterIcon,
} from "react-share";
import anchorme from "anchorme";
import filterXSS from "xss";

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
  "オンライン受講不可/Online attendance is NOT permitted.",
];

const useStyles = makeStyles((theme) => ({
  grid: {
    marginTop: "8px",
  },
  login: {
    position: "fixed",
    bottom: "50px",
    right: "30px",
    zIndex: "9999",
  },
  alert: {
    position: "fixed",
    bottom: "50px",
    left: "30px",
  },
  error: {
    fontWeight: "800",
  },
  a8: {
    border: "none",
    width: "100%",
  },
  evaluate: {
    marginLeft: "2%",
  },
  rating: {
    verticalAlign: "middle",
    marginLeft: "6px",
  },
  inputrate: {
    marginLeft: "6px",
  },
  number: {
    fontWeight: "300",
  },
  graph: {
    width: "50%",
  },
}));

var htmlscd = (function () {
  const map = {
    "&nbsp;": " ",
    "&lt;": "<",
    "&gt;": ">",
    "&amp;": "&",
    "&quot;": '"',
    "&apos;": "'",
    "&copy;": "©",
  };
  return function (src) {
    const re = /&#x([0-9A-Fa-f]+);|&#(\d+);|&\w+;|[^&]+|&/g;
    let text = "";
    let m;
    while ((m = re.exec(src)) !== null) {
      if (m[0].charAt(0) === "&") {
        if (m[0].length === 1) {
          // ？？？
          text = text + m[0];
        } else if (m[0].charAt(1) === "#") {
          // 数値文字参照
          if (m[0].charAt(2) === "x") {
            text = text + String.fromCharCode(parseInt(m[1], 16));
          } else {
            text = text + String.fromCharCode(m[2] - 0);
          }
        } else if (map.hasOwnProperty(m[0])) {
          // 定義済み文字実体参照
          text = text + map[m[0]];
        } else {
          // 未定義文字実体参照（諦める）
          text = text + m[0];
        }
      } else {
        // 通常文字列
        text = text + m[0];
      }
    }
    return text;
  };
})();

function encode_charactor(text) {
  const htmlText = anchorme({
    input: text,
    options: {
      attributes: () => {
        const attributes = {
          target: "_blank",
          rel: "noopener noreferrer",
        };
        return attributes;
      },
      exclude: function (string) {
        if (!string.startsWith("https://")) {
          return true;
        } else {
          return false;
        }
      },
    },
  });
  return (
    <span
      dangerouslySetInnerHTML={{
        __html: filterXSS(htmlText, {
          whiteList: {
            a: ["href", "title", "target", "rel"],
          },
        }),
      }}
    />
  );
}

function get_api(data, setData, id, history) {
  if (data === undefined) {
    // console.log(id);
    axios
      .get(`https://api.syllabus.tanemura.dev/all/${id}.json`) //リクエストを飛ばすpath
      .then(function (response) {
        if (
          response.data["【科目ナンバー/Course Number】授業名称"] === undefined
        ) {
          response.data["【科目ナンバー/Course Number】授業名称"] =
            response.data["name"];
          response.data["管理部署"] = ad_data[response.data["管理部署"]];
          response.data["開講キャンパス"] =
            campas_data[response.data["campas"]];
          response.data["授業形態"] = study[response.data["授業形態"]];
          response.data["緊急授業形態"] = study[response.data["緊急授業形態"]];
          response.data["オンライン授業形態"] =
            study[response.data["オンライン授業形態"]];
        }
        setData(response.data);
      })
      .catch(() => {
        history.push({
          pathname: "/404.html",
        });
      });
  }
}

export default function Subject(props) {
  const classes = useStyles();
  let [data, setData] = useState();
  const history = useHistory();
  // let [subscrive, setSubscrive] = useState("");
  let [alert, setAlert] = useState("");
  let [review, setReview] = useState("");
  let [star, setStar] = useState("3");
  let [hoverstar, setHoverstar] = useState("3");
  let [reason, setReason] = useState("");
  let [graph_data, setGraph_data] = useState({});
  // let [firebase_data, setFirebase_data] = useState([]);
  const location = useLocation();
  const id = location.pathname.replace("/subject/", "");
  useEffect(() => {
    get_api(data, setData, id, history);
  }, [data, id, history]);
  // let exc = ["春学期", "秋学期"];
  // let firebase_data1 = [];
  // if (props.user && !subscrive) {
  //   db.collection("users")
  //     .doc(props.user.uid)
  //     .get()
  //     .then((doc) => {
  //       if (doc.exists) {
  //         let i = 0;
  //         // let change = "";
  //         while (Object.keys(doc.data()).length - 1 >= i) {
  //           if (data === undefined) return;
  //           firebase_data1[i] = doc.data()[Object.keys(doc.data())[i]];
  //           // if (
  //           //   data["履修期"].indexOf(
  //           //     exc[parseInt(Object.keys(doc.data())[i].slice(-1)) - 1]
  //           //   ) !== -1 ||
  //           //   data["履修期"] === "通年"
  //           // ) {
  //           //   if (firebase_data1[i].indexOf(id) === -1) {
  //           //     change = "subscrive";
  //           //   } else {
  //           //     change = "Delete";
  //           //   }
  //           // }
  //           i++;
  //         }
  //         // setFirebase_data(firebase_data1);
  //         // setSubscrive(change);
  //       }
  //     });
  // }
  useEffect(() => {
    rdb
      .child("rate")
      .child(id)
      .get()
      .then((snapshot) => {
        if (snapshot.exists() && snapshot.val()["people"][0].length !== 0) {
          setReview(snapshot.val());
          let amp = snapshot.val()["people"];
          setGraph_data({
            labels: [
              "5(強くおすすめする)",
              "4(おすすめする)",
              "3(普通)",
              "2(あまりおすすめしない)",
              "1(おすすめしない)",
            ],
            datasets: [
              {
                data: [
                  (amp.filter(function (x) {
                    return x === 5 || x === "5";
                  }).length /
                    amp.length) *
                    100,
                  (amp.filter(function (x) {
                    return x === 4 || x === "4";
                  }).length /
                    amp.length) *
                    100,
                  (amp.filter(function (x) {
                    return x === 3 || x === "3";
                  }).length /
                    amp.length) *
                    100,
                  (amp.filter(function (x) {
                    return x === 2 || x === "2";
                  }).length /
                    amp.length) *
                    100,
                  (amp.filter(function (x) {
                    return x === 1 || x === "1";
                  }).length /
                    amp.length) *
                    100,
                ],
                backgroundColor: [
                  "rgba(87, 187, 138, 0.2)",
                  "rgba(154, 206, 106, 0.2)",
                  "rgba(255, 207, 2, 0.2)",
                  "rgba(255, 159, 2, 0.2)",
                  "rgba(255, 111, 49, 0.2)",
                ],
                borderColor: [
                  "rgba(87, 187, 138, 1)",
                  "rgba(154, 206, 106, 1)",
                  "rgba(255, 207, 2, 1)",
                  "rgba(255, 159, 2, 1)",
                  "rgba(255, 111, 49, 1)",
                ],
                borderWidth: 1,
              },
            ],
          });
        } else {
          setReview({ average: null, people: [], review: [], time: [] });
          // console.log("No data available");
        }
      })
      .catch((error) => {
        console.error(error);
      });
  }, [id]);

  // function onChange(term) {
  //   let termnum = [];
  //   let l = 0;
  //   if (data["履修期"].indexOf("通年") !== -1) {
  //     termnum.push("202201");
  //     termnum.push("202202");
  //   } else {
  //     for (let i = 0; i < exc.length; i++) {
  //       if (term.indexOf(exc[i]) !== -1) {
  //         termnum.push("20220" + (i + 1).toString());
  //       }
  //     }
  //   }
  // let terms = ["202201", "202202"];
  // l = terms.indexOf(termnum[0]);
  // if (subscrive === "subscrive") {
  //   let setfirebase = {};
  //   while (l < 2) {
  //     firebase_data[l].push(id);
  //     setfirebase[terms[l]] = firebase_data[l];
  //     l++;
  //   }
  //   db.collection("users")
  //     .doc(props.user.uid)
  //     .update(setfirebase)
  //     .then(setAlert("追加が完了しました"))
  //     .then(setSubscrive(""));
  // } else {
  //   while (l < 2) {
  //     db.collection("users")
  //       .doc(props.user.uid)
  //       .update({
  //         [terms[l]]: firebase_data[l].filter((item) => item !== id),
  //       })
  //       .then(setAlert("削除が完了しました"))
  //       .then(setSubscrive(""));
  //     l++;
  //   }
  // }
  // }

  const toTop = () => {
    history.push({
      pathname: "/",
    });
  };

  function convertToIsbn10(isbn13) {
    const sum = isbn13
      .split("")
      .slice(3, 12)
      .reduce((acc, c, i) => {
        return acc + (c[0] - "0") * (10 - i);
      }, 0);
    const checkDigit = 11 - (sum % 11);
    const isbn10 = isbn13.substring(3, 12) + checkDigit.toString();
    return isbn10;
  }

  const [open, setOpen] = React.useState(false);

  const handleClickOpen = () => {
    setReason(
      props.user && review["user"] != null && review["user"][props.user.uid]
        ? review["user"][props.user.uid]["review"]
        : null
    );
    setOpen(true);
  };

  const handleClose = () => {
    setOpen(false);
  };
  const labels = {
    1: "おすすめしない",
    2: "あまりおすすめしない",
    3: "普通",
    4: "おすすめする",
    5: "強くおすすめする",
  };

  function stripHtml(html) {
    // DOMParserを使用してHTMLを解析し、テキストを抽出する
    let withNewLines = html.replace(/<br\s*\/?>/gi, '\n');
    withNewLines = html.replace(/<BR\s*\/?>/gi, '\n');
    var doc = new DOMParser().parseFromString(withNewLines, 'text/html');
    let textContent = doc.body.textContent || "";
    textContent = textContent.replace(/\n+/g, '\n');
    return textContent || "";
  }
  

  function reviewSubmit(e) {
    if (reason) {
      review["review"][0] === ""
        ? (review["review"] = [reason])
        : review["review"].push(reason);
    }
    rdb
      .child("rate")
      .child(id)
      .child("user/" + props.user.uid)
      .set({
        star: parseInt(star),
        review: reason ? reason : "",
        date: Math.floor(Date.now() / 1000),
      })
      .then(setAlert("投稿完了しました。30秒後に反映されます。"));
    // console.log({
    //   star: parseInt(star),
    //   review: reason,
    //   date: Math.floor(Date.now() / 1000),
    // });
    setOpen(false);
    // window.location.reload();
  }

  const options = {
    indexAxis: "y",
    // Elements options apply to all of the options unless overridden in a dataset
    // In this case, we are setting the border of each horizontal bar to be 2px wide
    elements: {
      bar: {
        borderWidth: 1,
      },
    },
    responsive: true,
    plugins: {
      legend: {
        display: false,
      },
      title: {
        display: false,
      },
    },
  };

  function toteacher() {
    window.scrollTo(0, 0);
    history.push({
      pathname: "/searchResult",
      state: {
        all: data["担当者"],
        campas: "",
        term: "",
        ad: "",
        day: "",
        score: "",
        year: "",
        downloadedData: null,
      },
    });
  }
  return (
    <div>
      <HelmetProvider>
        <Helmet>
          <title>
            {data !== undefined
              ? data["【科目ナンバー/Course Number】授業名称"].substr(
                  0,
                  data["【科目ナンバー/Course Number】授業名称"].lastIndexOf(
                    "／"
                  )
                ) +
                " " +
                data["管理部署"].substr(0, data["管理部署"].indexOf("／")) +
                " - 関西学院大学 非公式シラバス/Syllabus"
              : "関西学院大学 非公式シラバス/Syllabus"}
          </title>
          <meta
            property="og:title"
            content={
              data !== undefined
                ? data["【科目ナンバー/Course Number】授業名称"].substr(
                    0,
                    data["【科目ナンバー/Course Number】授業名称"].lastIndexOf(
                      "／"
                    )
                  ) +
                  " " +
                  data["管理部署"].substr(0, data["管理部署"].indexOf("／")) +
                  " - 関西学院大学 非公式シラバス/Syllabus"
                : "関西学院大学 非公式シラバス/Syllabus"
            }
          />
          <meta property="og:type" content="article" />
          <meta
            property="og:url"
            content={"https://kgu-syllabus.com/subject/" + id}
          />
          <meta
            property="og:description"
            content={
              data
                ? data["管理部署"].substr(0, data["管理部署"].indexOf("／")) +
                  " / " +
                  data["履修期"]
                : null
            }
          />
          <link
            rel="canonical"
            href={"https://kgu-syllabus.com/subject/" + id}
          />
        </Helmet>
      </HelmetProvider>
      {alert ? (
        <Card>
          <Alert variant="filled" severity="success" className={classes.alert}>
            {alert}
          </Alert>
        </Card>
      ) : null}
      {/* <Alert variant="filled" severity="error" className={classes.error}>
      授業形態が「オンデマンドＢ型オンライン授業(時間割なし)」の場合でもシラバスに曜日,時限が記載されている場合は<u>時間割あり扱い</u>になります。
      そのため、授業は重複すれば取れなくなります。ご注意ください。
          </Alert> */}
      <Box mx={{ xs: 2, md: 8 }} mt={4}>
        <Breadcrumbs aria-label="breadcrumb">
          <Link color="inherit" onClick={toTop}>
            ホーム
          </Link>
          <Typography color="textPrimary">
            {data !== undefined ? (
              data["【科目ナンバー/Course Number】授業名称"].substr(
                0,
                data["【科目ナンバー/Course Number】授業名称"].lastIndexOf("／")
              )
            ) : (
              <Skeleton />
            )}
          </Typography>
        </Breadcrumbs>
        <Typography variant="body1" component="body1" display="inline">
          {data ? data["評価"][`項番No.1`][0] : "2022年度"}
        </Typography>
        <Box my={1}>
          <Typography variant="h3" component="h1">
            {data ? (
              data["【科目ナンバー/Course Number】授業名称"].substr(
                0,
                data["【科目ナンバー/Course Number】授業名称"].lastIndexOf("／")
              )
            ) : (
              <Skeleton />
            )}
          </Typography>
        </Box>
        <Typography variant="body1" component="body1" display="inline">
          {data ? (
            data["管理部署"].substr(0, data["管理部署"].indexOf("／")) +
            " / " +
            data["履修期"]
          ) : (
            <Skeleton />
          )}
        </Typography>
        {(() => {
          return (
            <Typography variant="body1" component="body1" display="inline">
              {review ? (
                <Rating
                  name="size-medium"
                  value={review["average"]}
                  className={classes.rating}
                  precision={0.5}
                  readOnly
                />
              ) : // review["people"].length
              null}
              {props.user ? (
                <Button
                  variant="contained"
                  color="primary"
                  className={classes.evaluate}
                  onClick={handleClickOpen}
                  startIcon={<ThumbsUpDownIcon />}
                >
                  評価する
                </Button>
              ) : null}
            </Typography>
          );
        })()}
        {props.user ? null : (
          <Typography variant="body2" component="h6">
            ログインすると評価できます
          </Typography>
        )}
        <Typography variant="body1" component="h6">
          <Typography variant="body2" component="body2" display="inline">
            教科の共有
          </Typography>
          {"  "}
          <LineShareButton
            url={"https://kgu-syllabus.com/subject/" + id}
            title={
              data
                ? data["【科目ナンバー/Course Number】授業名称"].substr(
                    0,
                    data["【科目ナンバー/Course Number】授業名称"].lastIndexOf(
                      "／"
                    )
                  ) +
                  " ( " +
                  data["管理部署"].substr(0, data["管理部署"].indexOf("／")) +
                  " / " +
                  data["履修期"] +
                  " ) "
                : null + "の授業"
            }
          >
            <LineIcon size={20} round={true} />
          </LineShareButton>
          {"  "}
          <TwitterShareButton
            url={"https://kgu-syllabus.com/subject/" + id}
            title={
              data
                ? data["【科目ナンバー/Course Number】授業名称"].substr(
                    0,
                    data["【科目ナンバー/Course Number】授業名称"].lastIndexOf(
                      "／"
                    )
                  ) +
                  " ( " +
                  data["管理部署"].substr(0, data["管理部署"].indexOf("／")) +
                  " / " +
                  data["履修期"] +
                  " ) "
                : null + "の授業"
            }
          >
            <TwitterIcon size={20} round={true}></TwitterIcon>
          </TwitterShareButton>
        </Typography>
        <Dialog
          open={open}
          onClose={handleClose}
          aria-labelledby="alert-dialog-title"
          aria-describedby="alert-dialog-description"
        >
          <DialogTitle id="alert-dialog-title">
            {data
              ? data["【科目ナンバー/Course Number】授業名称"].substr(
                  0,
                  data["【科目ナンバー/Course Number】授業名称"].lastIndexOf(
                    "／"
                  )
                )
              : null + "の授業を評価してください！"}
          </DialogTitle>
          <DialogContent>
            この授業を受けたことがある方のみ評価お願いします。このシラバスを見た方やこれからこの科目を取ろうか検討している方にどの程度お勧めできるか、また任意で理由やアドバイスをお書きください。（必修教科でもお願いします。）
            <DialogContentText id="alert-dialog-description">
              <Typography
                variant="h1"
                component="h1"
                display="inline"
                className={classes.number}
              >
                {hoverstar === -1 ? star : hoverstar}
                <Rating
                  defaultValue={3}
                  value={star}
                  onChange={(event, newValue) => {
                    setStar(newValue);
                  }}
                  onChangeActive={(event, newHover) => setHoverstar(newHover)}
                  emptyIcon={<StarBorderIcon fontSize="inherit" />}
                  className={classes.inputrate}
                />
              </Typography>
              <Typography
                variant="body1"
                component="body1"
                className={classes.inputrate}
              >
                {labels[hoverstar === -1 ? star : hoverstar]}
              </Typography>
            </DialogContentText>
            <TextField
              id="overreview"
              label="理由やアドバイス(任意)"
              multiline
              fullWidth
              rows={5}
              defaultValue={
                props.user &&
                review["user"] != null &&
                review["user"][props.user.uid]
                  ? review["user"][props.user.uid]["review"]
                  : null
              }
              variant="outlined"
              onChange={(event) => {
                setReason(event.target.value);
              }}
            />
          </DialogContent>
          <DialogActions>
            <Button onClick={handleClose} color="secondly">
              Back
            </Button>
            <Button onClick={(e) => reviewSubmit(e)} color="primary" autoFocus>
              Submit
            </Button>
          </DialogActions>
        </Dialog>

        <Box mt={{ xs: 1, md: 4 }} ml={{ xs: 1, md: 8 }}>
          <Subjectcontent
            title="単位数"
            content={data ? data["単位数"] : null}
            data={data}
            size="h5"
          />
          <Subjectcontent
            title="履修基準年度"
            content={data ? data["履修基準年度"] : null}
            data={data}
            size="h5"
          />
          <Subjectcontent
            title="履修登録方法"
            content={data && data["履修登録方法"] ? data["履修登録方法"] : null}
            data={data}
            size="h5"
            isred={data && data["履修登録方法"] && data["履修登録方法"].indexOf("申込制") !== -1 ? true : false}
          />
          {(() => {
            let render = [];
            if (data && data["履修登録方法"] && data["履修登録方法"].indexOf("予備登録") !== -1 ) {
              render.push( <Typography variant="body1" component="body1">「予備登録」とはあらかじめ事務室が行う履修登録。学生は登録不要。再履修生は各自で履修する必要あり<br /> </Typography>);
            }
            if (data && data["履修登録方法"] && data["履修登録方法"].indexOf("申込制") !== -1) {
              render.push( <Typography variant="body1" component="body1">「申込制科目」とは履修期間前の事前申込期間中にのみ履修申請可。定員があり、抽選制。履修から2ヶ月後の履修中止はできない。<br />  </Typography>);
            }
            if (data && data["履修登録方法"] && data["履修登録方法"].indexOf("本登録") !== -1) {
              render.push( <Typography variant="body1" component="body1">「本登録」とは履修期間中に履修できる科目 <br /> </Typography>);
            }
              if (data && data["履修登録方法"] && data["履修登録方法"].indexOf("その他") !== -1) {
              render.push( <Typography variant="body1" component="body1">「その他」とは例外的に、事務室窓口での履修申請等が必要 <br />  </Typography>);
            }
            return render
          })()}
          {(() => {
            let render = [];
            let a = 1;
            if (data) {
              while (data["評価"][`項番No.${a}`]) {
                render.push(
                  <Subjectcontent
                    title="曜時 & 教室"
                    content={data["評価"][`項番No.${a}`][2]}
                    subcontent={data["評価"][`項番No.${a}`][4]}
                    data={data}
                    size="h5"
                  />
                );
                a++;
              }
              return <div>{render}</div>;
            }
          })()}

          <Box mt={4}>
            {(() => {
              let returnjsx = [];
              if (data) {
                let a = 1;
                let name = `成績評価Grading${a}`;
                while (
                  data["評価"][name] !== undefined &&
                  data["評価"][name][0]
                ) {
                  if (a === 1) {
                    returnjsx.push(
                      <Grid item xs={12} md={2} className={classes.grid}>
                        <Typography variant="body1" component="body1">
                          成績
                        </Typography>
                      </Grid>
                    );
                  } else {
                    returnjsx.push(
                      <Grid item xs={12} md={2} mt={2} className={classes.grid}>
                        <Typography
                          variant="body1"
                          component="body1"
                        ></Typography>
                      </Grid>
                    );
                  }
                  // 備考
                  if (data["評価"][name][1].length === 1) {
                    returnjsx.push(
                      <Grid item xs={12} md={10}>
                        <Typography variant="body1" component="body1">
                          {data ? data["評価"][name] : <Skeleton />}
                        </Typography>
                      </Grid>
                    );
                  } else {
                    returnjsx.push(
                      <Grid item xs={9} md={5}>
                        <Typography variant="h5" component="body1">
                          {data ? (
                            data["評価"][name][0].substr(
                              0,
                              data["評価"][name][0].indexOf("／")
                            )
                          ) : (
                            <Skeleton />
                          )}
                        </Typography>
                      </Grid>
                    );
                    returnjsx.push(
                      <Grid item xs={3} md={1}>
                        <Typography
                          variant="h4"
                          component="h2"
                          display="inline"
                        >
                          {data ? (
                            data["評価"][name][1]
                              .split("<BR/>")
                              .map((str, index) => (
                                <React.Fragment key={index}>
                                  {str.slice(0, -1)}
                                  <Typography
                                    variant="body1"
                                    component="h2"
                                    display="inline"
                                  >
                                    %
                                  </Typography>
                                  <br />
                                </React.Fragment>
                              ))
                          ) : (
                            <Skeleton />
                          )}
                        </Typography>
                      </Grid>
                    );
                    returnjsx.push(
                      <Grid item xs={12} md={4}>
                        <Typography
                          variant="body1"
                          component="h2"
                          display="inline"
                        >
                          {data ? (
                            data["評価"][name][2]
                              .split("<BR/>")
                              .map((str, index) => (
                                <React.Fragment key={index}>
                                  {str}
                                  <br />
                                </React.Fragment>
                              ))
                          ) : (
                            <Skeleton />
                          )}
                        </Typography>
                      </Grid>
                    );
                  }
                  a++;
                  name = `成績評価Grading${a}`;
                }
                return (
                  <Grid
                    container
                    direction="row"
                    justifyContent="flex-start"
                    alignItems="center"
                    spacing={0}
                  >
                    {returnjsx}
                  </Grid>
                );
              }
            })()}
          </Box>
          <ins
            class="adsbygoogle"
            data-ad-client="ca-pub-7942690227296112"
            data-ad-slot="8030267441"
            data-ad-format="auto"
            data-full-width-responsive="true"
          />
          {data ? (
            <Link onClick={toteacher}>
              <Subjectcontent
                title="担当者"
                content={data ? data["担当者"] : null}
                data={data}
                size="subtitle1"
              />
            </Link>
          ) : null}
          <Subjectcontent
            title="場所"
            content={data ? data["開講キャンパス"] : null}
            data={data}
            size="h5"
          />

          {/* {props.user && subscrive ? (
            <Button
              variant="contained"
              color="primary"
              className={classes.login}
              onClick={() => onChange(data["履修期"])}
            >
              {subscrive}
            </Button>
          ) : null} */}
          <Box mt={8}>
            <Subjectcontent
              title="授業形態"
              content={
                data
                  ? data["授業形態"]
                    ? data["授業形態"].split("/")[0]
                    : data["授業形態"]
                  : null
              }
              data={data}
              size="h5"
            />
            <Subjectcontent
              title="授業形態"
              content={
                data && data["緊急授業形態"]
                  ? data["緊急授業形態"]
                    ? data["緊急授業形態"].split("/")[0]
                    : data["緊急授業形態"]
                  : null
              }
              data={data}
              size="h5"
            />
            <Subjectcontent
              title="授業形態（オンライン許可のみ）"
              content={
                data
                  ? data["オンライン授業形態"]
                    ? data["オンライン授業形態"].split("/")[0]
                    : data["オンライン授業形態"]
                  : null
              }
              data={data}
              size="body1"
            />
            <Subjectcontent
              title="主な教授言語"
              content={data ? data["主な教授言語"] : null}
              data={data}
              size="body1"
            />
            <Subjectcontent
              title="授業方法"
              content={
                data
                  ? stripHtml(data["授業方法"]).split("\n").map((str, index) => (
                      <React.Fragment key={index}>
                        {htmlscd(str)}
                        <br />
                      </React.Fragment>
                    ))
                  : null
              }
              data={data}
              size="body1"
            />
            <Subjectcontent
              title="授業目的"
              content={
                data
                  ? stripHtml(data["授業目的"]).split("\n").map((str, index) => (
                      <React.Fragment key={index}>
                        {htmlscd(str)}
                        <br />
                      </React.Fragment>
                    ))
                  : null
              }
              data={data}
              size="body1"
            />
            <Subjectcontent
              title="到達目標"
              content={
                data
                  ? stripHtml(data["到達目標"]).split("\n").map((str, index) => (
                      <React.Fragment key={index}>
                        {htmlscd(str)}
                        <br />
                      </React.Fragment>
                    ))
                  : null
              }
              data={data}
              size="body1"
            />
            <Subjectcontent
              title="特記事項"
              content={
                data ? (
                  data["特記事項"] ? (
                    stripHtml(data["特記事項"]).split("\n").map((str, index) => (
                      <React.Fragment key={index}>
                        {htmlscd(str)}
                        <br />
                      </React.Fragment>
                    ))) : null
                ) : null
              }
              data={data}
              size="body1"
            />
            {(() => {
              if (data) {
                if (data["授業の概要・背景"]) {
                  return (
                    <Subjectcontent
                      title="授業の概要・背景"
                      content={
                        data ? (
                          data["授業の概要・背景"] ? (
                            stripHtml(data["授業の概要・背景"]).split("\n").map((str, index) => (
                              <React.Fragment key={index}>
                                {htmlscd(str)}
                                <br />
                              </React.Fragment>))) : null
                         ) : null
                      }
                      data={data}
                      size="body1"
                    />
                  );
                }
              }
            })()}
          </Box>
          {(() => {
            if (data) {
              let result = [];
              let b = 1;
              let title = `第${b}回`;
              if (!data["トピック"][title]) {
                let i = 0;
                while (Object.keys(data["トピック"]).length > i) {
                  result.push(
                    <Typography>
                        {data["トピック"][Object.keys(data["トピック"])[i]] ? (
                            stripHtml(data["トピック"][Object.keys(data["トピック"])[i]]).split("\n").map((str, index) => (
                              <React.Fragment key={index}>
                                {htmlscd(str)}
                                <br />
                              </React.Fragment>))) : null}
                    </Typography>
                  );
                  i++;
                }
              } else {
                while (data["トピック"][title]) {
                  result.push(
                    <Accordion>
                      <AccordionSummary expandIcon={<ExpandMoreIcon />}>
                        <Typography className={classes.heading}>
                          {title + data["トピック"][title][0].split("<BR/>")[0]}
                        </Typography>
                      </AccordionSummary>
                      <AccordionDetails>
                        <Box>
                          <Typography>
                          {data["トピック"][title][0] ? (
                            stripHtml(data["トピック"][title][0]).split("\n").map((str, index) => (
                              <React.Fragment key={index}>
                                {htmlscd(str)}
                                <br />
                              </React.Fragment>))) : null}
                          </Typography>
                          <Typography>
                            <Typography>
                            {data["トピック"][title][1] ? (
                            stripHtml(data["トピック"][title][1]).split("\n").map((str, index) => (
                              <React.Fragment key={index}>
                                {htmlscd(str)}
                                <br />
                              </React.Fragment>))) : null}
                            </Typography>
                          </Typography>
                        </Box>
                      </AccordionDetails>
                    </Accordion>
                  );
                  b++;
                  title = `第${b}回`;
                }
              }
              return (
                <Box mt={4}>
                  {data["トピック"][title] ? (
                    <Grid
                      container
                      direction="row"
                      justifyContent="flex-start"
                      alignItems="center"
                      spacing={0}
                    >
                      <Grid item xs={1}>
                        <Typography variant="body1" component="body1">
                          授業計画、授業外学習
                        </Typography>
                      </Grid>
                      <Grid item xs={11}>
                        {result}
                      </Grid>
                    </Grid>
                  ) : (
                    <Grid
                      container
                      direction="row"
                      justifyContent="flex-start"
                      alignItems="center"
                      spacing={0}
                    >
                      <Grid item xs={12} md={2} mt={4}>
                        <Typography variant="body1" component="body1">
                          授業計画、授業外学習
                        </Typography>
                      </Grid>
                      <Grid item xs={12} md={10}>
                        {result}
                      </Grid>
                    </Grid>
                  )}
                </Box>
              );
            }
          })()}
          {(() => {
            if (data) {
              if (data["トピック"]["授業外学習2"]) {
                return (
                  <Subjectcontent
                    title="授業外学修"
                    content={
                      data ? (
                        data["トピック"]["授業外学習2"] ? (
                            stripHtml(data["トピック"]["授業外学習2"]).split("\n").map((str, index) => (
                              <React.Fragment key={index}>
                                {htmlscd(str)}
                                <br />
                              </React.Fragment>))) : null
                      ) : null
                    }
                    data={data}
                    size="body1"
                  />
                );
              }
            }
          })()}
          {(() => {
            if (data) {
              let i = 0;
              let result = [];

              while (Object.keys(data["評価"])[i]) {
                if (
                  Object.keys(data["評価"])[i].indexOf("項番") !== -1 ||
                  Object.keys(data["評価"])[i].indexOf("成績") !== -1 ||
                  Object.keys(data["評価"])[i].indexOf("教科書") !== -1 ||
                  Object.keys(data["評価"])[i].indexOf("参考書") !== -1 ||
                  Object.keys(data["評価"])[i].indexOf("参考文献") !== -1 ||
                  /^\d+$/.test(Object.keys(data["評価"])[i])
                ) {
                  i++;
                } else {
                  result.push(
                    <Subjectcontent
                      title={Object.keys(data["評価"])[i].substr(
                        0,
                        Object.keys(data["評価"])[i].indexOf("/") === -1
                          ? Object.keys(data["評価"])[i].length
                          : Object.keys(data["評価"])[i].indexOf("/") - 1
                      )}
                      content={
                        data ? data["評価"][Object.keys(data["評価"])[i]] : null
                      }
                      data={data}
                      size="body1"
                    />
                  );
                  i++;
                }
              }
              return result;
            }
          })()}
          <Box mt={4}>
            <Grid
              container
              direction="row"
              justifyContent="flex-start"
              alignItems="center"
              spacing={0}
            >
              <Grid item xs={12} md={1}>
                <Typography variant="body1" component="body1">
                  教科書
                </Typography>
              </Grid>
              <Grid item xs={12} md={11}>
                <TableContainer component={Paper}>
                  <Table className={classes.table} aria-label="simple table">
                    <TableHead>
                      <TableRow>
                        <TableCell>タイトル</TableCell>
                        <TableCell align="left">著者名</TableCell>
                        <TableCell align="left">発行所</TableCell>
                        <TableCell align="left">出版年</TableCell>
                        <TableCell align="left">ISBN</TableCell>
                        <TableCell align="left">Amazon</TableCell>
                      </TableRow>
                    </TableHead>
                    <TableBody>
                      {(() => {
                        if (data) {
                          let i = 0;
                          let result = [];
                          let title = `教科書Required texts${i}`;

                          if (
                            Object.keys(data["評価"]).indexOf(
                              "教科書/Required texts0"
                            ) !== -1
                          ) {
                            i = 1;
                            title = `教科書/Required texts${i}`;
                          }
                          while (data["評価"][title]) {
                            if (data["評価"][title][1].length === 1) {
                              return (
                                <TableCell align="left" colSpan={6}>
                                  {data["評価"][title]}
                                </TableCell>
                              );
                            }
                            result.push(
                              <TableRow key={i}>
                                <TableCell align="left">
                                  {data["評価"][title][1]}
                                </TableCell>
                                <TableCell align="left">
                                  {data["評価"][title][0]}
                                </TableCell>
                                <TableCell align="left">
                                  {data["評価"][title][2]}
                                </TableCell>
                                <TableCell align="left">
                                  {data["評価"][title][3]}
                                </TableCell>
                                <TableCell align="left">
                                  {data["評価"][title][4]}
                                </TableCell>
                                <TableCell align="left">
                                  <Link
                                    target="_blank"
                                    href={
                                      data["評価"][title][4].replaceAll("-", "")
                                        .length === 13
                                        ? "https://www.amazon.co.jp/gp/product/" +
                                          convertToIsbn10(
                                            data["評価"][title][4].replaceAll(
                                              "-",
                                              ""
                                            )
                                          ) +
                                          "?pf_rd_r=0V34BQC9CC75KKFHJYTY&pf_rd_p=3a18ae70-29cd-40df-b252-334783771910&pd_rd_r=670d7540-8ef3-42a3-adf8-cd65cf3c44d7&pd_rd_w=xe2JN&pd_rd_wg=WxfEx&linkCode=ll1&tag=tane38-22&linkId=fa67bfe005978bc7f829301e7265fc49&language=ja_JP&ref_=as_li_ss_tl"
                                        : "https://www.amazon.co.jp/gp/product/" +
                                          data["評価"][title][4].replaceAll(
                                            "-",
                                            ""
                                          ) +
                                          "?pf_rd_r=0V34BQC9CC75KKFHJYTY&pf_rd_p=3a18ae70-29cd-40df-b252-334783771910&pd_rd_r=670d7540-8ef3-42a3-adf8-cd65cf3c44d7&pd_rd_w=xe2JN&pd_rd_wg=WxfEx&linkCode=ll1&tag=tane38-22&linkId=fa67bfe005978bc7f829301e7265fc49&language=ja_JP&ref_=as_li_ss_tl"
                                    }
                                    color="blue"
                                  >
                                    Amazon
                                  </Link>
                                </TableCell>
                              </TableRow>
                            );
                            i++;
                            if (
                              Object.keys(data["評価"]).indexOf(
                                "教科書/Required texts0"
                              ) !== -1
                            ) {
                              title = `教科書/Required texts${i}`;
                            }
                          }
                          if (
                            Object.keys(data["評価"]).indexOf(
                              "教科書/Required texts0"
                            ) !== -1
                          ) {
                            let title = `教科書Required texts0`;
                            result.push(
                              <TableCell>{data["評価"][title]}</TableCell>
                            );
                          }
                          return result;
                        }
                      })()}
                    </TableBody>
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
                <Typography variant="body1" component="body1">
                  参考文献
                </Typography>
              </Grid>
              <Grid item xs={12} md={11}>
                <TableContainer component={Paper}>
                  <Table className={classes.table} aria-label="simple table">
                    <TableHead>
                      <TableRow>
                        <TableCell>タイトル</TableCell>
                        <TableCell align="left">著者名</TableCell>
                        <TableCell align="left">発行所</TableCell>
                        <TableCell align="left">出版年</TableCell>
                        <TableCell align="left">ISBN</TableCell>
                        <TableCell align="left">Amazon</TableCell>
                      </TableRow>
                    </TableHead>
                    <TableBody>
                      {(() => {
                        if (data) {
                          let i = 0;
                          let result = [];
                          let title = `参考文献・資料Reference books${i}`;
                          if (
                            Object.keys(data["評価"]).indexOf(
                              "参考書/Reference books0"
                            ) !== -1
                          ) {
                            i = 1;
                            title = `参考書/Reference books${i}`;
                          }
                          while (data["評価"][title]) {
                            if (data["評価"][title][1].length === 1) {
                              return (
                                <TableCell align="left" colSpan={6}>
                                  {data["評価"][title]}
                                </TableCell>
                              );
                            }
                            result.push(
                              <TableRow key={i}>
                                {/* <TableCell
                                  component="th"
                                  scope="row"
                                ></TableCell> */}
                                <TableCell align="left">
                                  {data["評価"][title][1]}
                                </TableCell>
                                <TableCell align="left">
                                  {data["評価"][title][0]}
                                </TableCell>
                                <TableCell align="left">
                                  {data["評価"][title][2]}
                                </TableCell>
                                <TableCell align="left">
                                  {data["評価"][title][3]}
                                </TableCell>
                                <TableCell align="left">
                                  {data["評価"][title][4]}
                                </TableCell>
                                <TableCell align="left">
                                  <Link
                                    href={
                                      data["評価"][title][4].replaceAll("-", "")
                                        .length === 13
                                        ? "https://www.amazon.co.jp/gp/product/" +
                                          convertToIsbn10(
                                            data["評価"][title][4].replaceAll(
                                              "-",
                                              ""
                                            )
                                          ) +
                                          "?pf_rd_r=0V34BQC9CC75KKFHJYTY&pf_rd_p=3a18ae70-29cd-40df-b252-334783771910&pd_rd_r=670d7540-8ef3-42a3-adf8-cd65cf3c44d7&pd_rd_w=xe2JN&pd_rd_wg=WxfEx&linkCode=ll1&tag=tane38-22&linkId=fa67bfe005978bc7f829301e7265fc49&language=ja_JP&ref_=as_li_ss_tl"
                                        : "https://www.amazon.co.jp/gp/product/" +
                                          data["評価"][title][4].replaceAll(
                                            "-",
                                            ""
                                          ) +
                                          "?pf_rd_r=0V34BQC9CC75KKFHJYTY&pf_rd_p=3a18ae70-29cd-40df-b252-334783771910&pd_rd_r=670d7540-8ef3-42a3-adf8-cd65cf3c44d7&pd_rd_w=xe2JN&pd_rd_wg=WxfEx&linkCode=ll1&tag=tane38-22&linkId=fa67bfe005978bc7f829301e7265fc49&language=ja_JP&ref_=as_li_ss_tl"
                                    }
                                    color="blue"
                                  >
                                    Amazon
                                  </Link>
                                </TableCell>
                              </TableRow>
                            );
                            i++;
                            if (
                              Object.keys(data["評価"]).indexOf(
                                "参考書/Reference books0"
                              ) !== -1
                            ) {
                              title = `参考書/Reference books${i}`;
                            } else {
                              title = `参考文献・資料Reference books${i}`;
                            }
                          }
                          if (
                            Object.keys(data["評価"]).indexOf(
                              "参考書/Reference books0"
                            ) !== -1
                          ) {
                            let title = `参考文献・資料Reference books0`;
                            result.push(
                              <TableCell>{data["評価"][title]}</TableCell>
                            );
                          }
                          return result;
                        }
                      })()}
                    </TableBody>
                  </Table>
                </TableContainer>
              </Grid>
            </Grid>
            <Box my={4}>
              {review["review"] != null ? (
                <Card>
                  <Box ml={3} p={2}>
                    {(() => {
                      if (review["average"] !== null) {
                        return (
                          <Grid
                            container
                            direction="row"
                            justifyContent="flex-start"
                            alignItems="center"
                            spacing={0}
                          >
                            <Grid item xs={12} sm={3}>
                              <Typography variant="body1" component="body1">
                                評価
                              </Typography>
                              <Typography
                                variant="h1"
                                component="h1"
                                className={classes.number}
                              >
                                {review["average"].toFixed(2)}
                              </Typography>
                              <Typography
                                variant="h6"
                                component="h6"
                                className={classes.number}
                              >
                                <Rating
                                  name="size-medium"
                                  value={review["average"]}
                                  className={classes.rating}
                                  readOnly
                                />
                              </Typography>
                              <Box ml={2} pt={1}>
                                <Typography variant="body1" component="body1">
                                  {review["people"][0] === ""
                                    ? 0
                                    : review["people"].length}
                                  件のレビュー
                                </Typography>
                              </Box>
                            </Grid>
                            <Grid item xs={12} sm={9}>
                              {/* {console.log(graph_data)} */}
                              {graph_data["datasets"] !== undefined &&
                              graph_data ? (
                                <Bar
                                  data={graph_data}
                                  options={options}
                                  className={classes.graph}
                                />
                              ) : null}
                            </Grid>
                          </Grid>
                        );
                      }
                    })()}
                  </Box>
                </Card>
              ) : null}
               <Box mt={1}>
                {review["review"] == null || review["review"][0] === ""
                  ? null
                  : review["review"].map((value, index) => (
                      <Box mt={1}>
                        <Card>
                          <CardContent>{value}</CardContent>
                          <Box ml={1}>
                            <Typography
                              className={classes.pos}
                              color="textSecondary"
                            >
                              {new Date(
                                review["time"][index] * 1000
                              ).toDateString()}
                              にレビュー済み
                            </Typography>
                          </Box>
                        </Card>
                      </Box>
                    ))}
              </Box>
            </Box>
            <Box mt={4}>
            <Grid
              container
              direction="row"
              justifyContent="flex-start"
              alignItems="center"
              spacing={0}
            >
              <Grid item xs={12} md={1}>
                <Typography variant="body1" component="body1">
                  引用元
                </Typography>
              </Grid>
              <Grid item xs={12} md={11}>
                <Typography variant="body1" component="body1">
                  関西学院大学シラバス"シラバス情報 条件指定画面"より
                </Typography>
              </Grid>
            </Grid>
          </Box>
            <Box my={4}>
              教室の場所、単位数、曜日、時間、成績評価方法はこのページ上部に記載しています。
            </Box>
            <ins
              class="adsbygoogle"
              data-ad-client="ca-pub-7942690227296112"
              data-ad-slot="8030267441"
              data-ad-format="auto"
              data-full-width-responsive="true"
            />
          </Box>
        </Box>
      </Box>
    </div>
  );
}
