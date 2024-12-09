import "./App.css";
import { makeStyles, useTheme } from "@material-ui/core/styles";
import { Box } from "@material-ui/core";
import SearchForm from "./SearchForm";
import { useHistory, useLocation } from "react-router-dom";
import React, { useEffect } from "react";
import Table from "@material-ui/core/Table";
import TableBody from "@material-ui/core/TableBody";
import TableCell from "@material-ui/core/TableCell";
import TableContainer from "@material-ui/core/TableContainer";
import TableHead from "@material-ui/core/TableHead";
import TablePagination from "@material-ui/core/TablePagination";
import TableRow from "@material-ui/core/TableRow";
import IconButton from "@material-ui/core/IconButton";
import FirstPageIcon from "@material-ui/icons/FirstPage";
import KeyboardArrowLeft from "@material-ui/icons/KeyboardArrowLeft";
import KeyboardArrowRight from "@material-ui/icons/KeyboardArrowRight";
import LastPageIcon from "@material-ui/icons/LastPage";
import PropTypes from "prop-types";
import TableFooter from "@material-ui/core/TableFooter";
import TableSortLabel from "@material-ui/core/TableSortLabel";
import Hidden from "@material-ui/core/Hidden";
let columns = [];

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
let day_data = [
  "月１",
  "月２",
  "月３",
  "月４",
  "月５",
  "月６",
  "月７",
  "火１",
  "火２",
  "火３",
  "火４",
  "火５",
  "火６",
  "火７",
  "水１",
  "水２",
  "水３",
  "水４",
  "水５",
  "水６",
  "水７",
  "木１",
  "木２",
  "木３",
  "木４",
  "木５",
  "木６",
  "木７",
  "金１",
  "金２",
  "金３",
  "金４",
  "金５",
  "金６",
  "金７",
  "土１",
  "土２",
  "土３",
  "土４",
  "土５",
  "土６",
  "土７",
  "日１",
  "日２",
  "日３",
  "日４",
  "日５",
  "日６",
  "‐",
  "集中・その他",
];
let term_data = [
  "通年／Year Round",
  "春学期／Spring",
  "秋学期／Fall",
  "春学期前半／Spring (1st Half)",
  "春学期後半／Spring (2nd Half)",
  "秋学期前半／Fall (1st Half)",
  "秋学期後半／Fall (2nd Half)",
  "通年集中／Intensive (Year Round)",
  "春学期集中／Intensive (Spring)",
  "秋学期集中／Intensive (Fall)",
  "春学期前半集中／Intensive (Spring 1st Half)",
  "春学期後半集中／Intensive (Spring 2nd Half)",
  "秋学期前半集中／Intensive (Fall 1st Half)",
  "秋学期後半集中／Intensive (Fall 2nd Half)",
];
let score = [
  "定期試験",
  "定期試験に代わるリポート",
  "授業中試験",
  "平常リポート",
  "プレゼンテーション・発表",
  "授業への参加度（自発性、積極性、主体性、等）",
  "その他",
  "授業外学修課題",
  "論文",
  "実技, 実験"
];

let study = [
  "対面授業",
  "同時双方向型オンライン授業",
  "オンデマンドＡ型オンライン授業(時間割あり)",
  "オンデマンドＢ型オンライン授業(時間割なし)",
  "オンライン受講不可/Online attendance is NOT permitted.",
];

let howto_data = [
  "すべて",
  "「本登録」を含む",
  "「予備登録」を含む",
  "「申込科目」を含む",
]


if (window.matchMedia("(max-width: 550px)").matches) {
  columns = [
    // {id: "id", field: "id", headerName: "ID", flex: 1},
    {
      id: "name",
      field: "name",
      headerName: "授業名",
      width: "100",
    },
    // { id: "prof", field: "担当者", headerName: "担当者"},
    { id: "ad", field: "管理部署A", headerName: "部署", width: "100" },
    // { field: '履修基準年度', headerName: '履修基準年度', width: "100" },
    // { field: "曜時", headerName: "曜時", flex: 1 },
    { field: "開講期A", headerName: "開講期", width: "100" },
    { id: "grade", field: "単位数", headerName: "単位", width: "100" },
    // { field: '評価項目', headerName: '評価項目', width: 130 }
  ];
} else {
  columns = [
    { id: "id", field: "id", headerName: "ID", flex: 1 },
    {
      id: "name",
      field: "name",
      headerName: "【科目ナンバー/Course Number】授業名称",
      flex: 4,
    },
    { id: "prof", field: "担当者", headerName: "担当者", flex: 2 },
    { id: "ad", field: "管理部署A", headerName: "管理部署", flex: 2 },
    { id: "履修登録方法", field: "履修登録方法", headerName: "履修登録方法", flex: 1 },
    { id: "評価", field: "評価", headerName: "評価", flex: 1 },
    { field: "時限", headerName: "曜時", flex: 1 },
    { field: "開講期A", headerName: "開講期", flex: 1 },
    { field: "履修基準年度", headerName: "履修基準年度", width: "100" },
    { id: "grade", field: "単位数", headerName: "単位数", flex: 1 },
    { id: "授業", field: "授業", headerName: "授業形態", flex: 1 },
  ];
}

function hankaku2Zenkaku(str) {
  return str.replace(/[Ａ-Ｚａ-ｚ０-９]/g, function (s) {
    return String.fromCharCode(s.charCodeAt(0) - 0xfee0);
  });
}

const useStyles = makeStyles((theme) => ({
  root: {
    width: "10px",
    fontSize: "16px",
  },
  error: {
    fontWeight: "800",
  },
  container: {
    maxHeight: 10000,
    //   [theme.breakpoints.down("xs")]: {
    // whiteSpace: "nowrap",
    // overflowX: "auto",
    // padding: "0!important",
    // tableLayout: 'auto'
    //   }
  },
  bc: {
    backgroundColor: "white",
    [theme.breakpoints.down("xs")]: {
      // whiteSpace: "nowrap!important",
      // overflowX: "auto!important",
      padding: "0!important",
      // width:"10px!important",
      // tableLayout: 'auto!important'
    },
    // tableLayout: 'fixed'
  },
  bbc: {
    [theme.breakpoints.down("xs")]: {
      // whiteSpace: "nowrap!important",
      // overflowX: "auto!important",
      padding: "0 0 0 12px!important",
      // width:"10px!important",
      // tableLayout: 'auto!important'
    },
    //   // tableLayout: 'fixed'
  },
  ac: {
    [theme.breakpoints.down("xs")]: {
      // whiteSpace: 'nowrap',
      // padding: "0!important",
      // display: "list-item"
      // width:"10px!important",
      // tableLayout: "auto",
    },
  },
  visuallyHidden: {
    border: 0,
    clip: "rect(0 0 0 0)",
    height: 1,
    margin: -1,
    overflow: "hidden",
    padding: 0,
    position: "absolute",
    top: 20,
    width: 1,
  },
  a8: {
    width: "10px!important",
  },
}));

const useStyles1 = makeStyles((theme) => ({
  root: {
    display: "contents",
    [theme.breakpoints.down("xs")]: {
      display: "inline-flex!important",
    },
  },
}));

function descendingComparator(a, b, orderBy) {
  if (b[orderBy] < a[orderBy]) {
    return -1;
  }
  if (b[orderBy] > a[orderBy]) {
    return 1;
  }
  return 0;
}

function getComparator(order, orderBy) {
  return order === "desc"
    ? (a, b) => descendingComparator(a, b, orderBy)
    : (a, b) => -descendingComparator(a, b, orderBy);
}

function stableSort(array, comparator) {
  const stabilizedThis = array.map((el, index) => [el, index]);
  stabilizedThis.sort((a, b) => {
    if (typeof a === "string") {
      var nameA = a.toUpperCase();
      var nameB = b.toUpperCase();
      if (nameA < nameB) {
        return -1;
      }
      if (nameA > nameB) {
        return 1;
      }
      return 0;
    } else {
      const order = comparator(a[0], b[0]);
      if (order !== 0) return order;
      return a[1] - b[1];
    }
  });
  return stabilizedThis.map((el) => el[0]);
}

function TablePaginationActions(props) {
  const classes = useStyles1();
  const theme = useTheme();
  const { count, page, rowsPerPage, onPageChange } = props;

  const handleFirstPageButtonClick = (event) => {
    onPageChange(event, 0);
  };

  const handleBackButtonClick = (event) => {
    onPageChange(event, page - 1);
  };

  const handleNextButtonClick = (event) => {
    onPageChange(event, page + 1);
  };

  const handleLastPageButtonClick = (event) => {
    onPageChange(event, Math.max(0, Math.ceil(count / rowsPerPage) - 1));
  };

  return (
    <div className={classes.root}>
      <IconButton
        onClick={handleFirstPageButtonClick}
        disabled={page === 0}
        aria-label="first page"
      >
        {theme.direction === "rtl" ? <LastPageIcon /> : <FirstPageIcon />}
      </IconButton>
      <IconButton
        onClick={handleBackButtonClick}
        disabled={page === 0}
        aria-label="previous page"
      >
        {theme.direction === "rtl" ? (
          <KeyboardArrowRight />
        ) : (
          <KeyboardArrowLeft />
        )}
      </IconButton>
      <IconButton
        onClick={handleNextButtonClick}
        disabled={page >= Math.ceil(count / rowsPerPage) - 1}
        aria-label="next page"
      >
        {theme.direction === "rtl" ? (
          <KeyboardArrowLeft />
        ) : (
          <KeyboardArrowRight />
        )}
      </IconButton>
      <IconButton
        onClick={handleLastPageButtonClick}
        disabled={page >= Math.ceil(count / rowsPerPage) - 1}
        aria-label="last page"
      >
        {theme.direction === "rtl" ? <FirstPageIcon /> : <LastPageIcon />}
      </IconButton>
    </div>
  );
}

TablePaginationActions.propTypes = {
  count: PropTypes.number.isRequired,
  onPageChange: PropTypes.func.isRequired,
  page: PropTypes.number.isRequired,
  rowsPerPage: PropTypes.number.isRequired,
  order: PropTypes.oneOf(["asc", "desc"]).isRequired,
  orderBy: PropTypes.string.isRequired,
};
function ForsumartPhone(key) {
  key["name"] = key["name"].replace(/【[0-9]{1,3}】/i, "");
  if (key["管理部署A"].indexOf("／") !== -1) {
    key["管理部署A"] = key["管理部署A"].substring(
      0,
      key["管理部署A"].indexOf("／")
    );
  }
  if (key["開講期A"].indexOf("／") !== -1) {
    key["開講期A"] = key["開講期A"].substring(0, key["開講期A"].indexOf("／"));
  }
  return key;
}

function ForPC(key) {
  if (key["管理部署A"] !== undefined) {
    if (key["管理部署A"].indexOf("／") !== -1) {
      key["管理部署A"] = key["管理部署A"].substring(
        0,
        key["管理部署A"].indexOf("／")
      );
    }
  }
  if (key["開講期A"] !== undefined) {
    if (key["開講期A"].indexOf("／") !== -1) {
      key["開講期A"] = key["開講期A"].substring(
        0,
        key["開講期A"].indexOf("／")
      );
    }
  }
  let term_time = "";
  if (key["時限"] === undefined) {
    for (const elem in Object.keys(key)) {
      if (Object.keys(key)[parseInt(elem)].indexOf("時限") !== -1) {
        if (
          key["授業形態"] === 3 &&
          key[Object.keys(key)[parseInt(elem)]] !== 49
        ) {
          term_time +=
            "<オンデマンドＢ型ですが、時間割指定科目です>" +
            day_data[key[Object.keys(key)[parseInt(elem)]]];
        } else {
          term_time += day_data[key[Object.keys(key)[parseInt(elem)]]] + "";
        }
      }
    }
    key["時限"] = term_time;
  }

  let grade_time = "";
  if (key["評価"] === undefined) {
    for (const elem in Object.keys(key)) {
      if (Object.keys(key)[parseInt(elem)].indexOf("評価") !== -1 && isNaN(key[Object.keys(key)[parseInt(elem)]]) === false) {
        grade_time += score[key[Object.keys(key)[parseInt(elem)]]] + " / ";
      }
    }
    key["評価"] = grade_time.slice(0, -3);
  }

  if (key["授業"] === undefined) {
    if (key["緊急授業形態"] !== undefined) {
      key["授業"] = study[key["緊急授業形態"]];
    }
  }
  // console.log(key);
  return key;
}

function SearchEngine(key) {
  var result = [];
  let all = 0;
  //先頭が[このマークであれば。
  if (key.all.slice(1, 2) === "【") {
    key.all = key.all.slice(1);
  }
  for (var item in key.downloadedData) {
    if (key.howto === "" || key.howto === 0 || (key.howto === 1 && key.downloadedData[item]["履修登録方法"] !== undefined && key.downloadedData[item]["履修登録方法"].indexOf("本登録") !== -1 )
    || (key.howto === 2 && key.downloadedData[item]["履修登録方法"] !== undefined && key.downloadedData[item]["履修登録方法"].indexOf("予備") !== -1 ) ||
   (key.howto === 3 && key.downloadedData[item]["履修登録方法"] !== undefined && key.downloadedData[item]["履修登録方法"].indexOf("申込") !== -1 )
){
    if (
      key.downloadedData[item]["name"].indexOf(key.all) !== -1 ||
      key.downloadedData[item]["担当者"].indexOf(key.all) !== -1 ||
      key.downloadedData[item]["担当者"]
        .replaceAll("　", "")
        .indexOf(key.all) !== -1 ||
      key.downloadedData[item]["name"].toLowerCase().indexOf(key.all) !== -1 ||
      key.downloadedData[item]["担当者"].toLowerCase().indexOf(key.all) !==
        -1 ||
      key.downloadedData[item]["担当者"]
        .toLowerCase()
        .replaceAll("　", "")
        .indexOf(key.all) !== -1 ||
      hankaku2Zenkaku(key.downloadedData[item]["name"]).indexOf(key.all) !==
        -1 ||
      hankaku2Zenkaku(key.downloadedData[item]["name"])
        .toLowerCase()
        .indexOf(key.all) !== -1 ||
      hankaku2Zenkaku(key.downloadedData[item]["担当者"])
        .replaceAll("　", "")
        .toLowerCase()
        .indexOf(key.all) !== -1 ||
      hankaku2Zenkaku(key.downloadedData[item]["担当者"]).indexOf(key.all) !==
        -1 ||
      hankaku2Zenkaku(key.downloadedData[item]["担当者"])
        .replaceAll("　", "")
        .indexOf(key.all) !== -1 ||
      hankaku2Zenkaku(key.downloadedData[item]["担当者"])
        .toLowerCase()
        .indexOf(key.all) !== -1
    ) {
      all = 0;
      if (key.campas === 0) {
        all = 1;
      }
      if (
        (key.campas !== 0 && key.campas === "") ||
        all === 1 ||
        key.downloadedData[item]["campas"] + 1 === key.campas
      ) {
        all = 0;
        if (key.year === 0) {
          all = 1;
        }
        if (
          (key.year !== 0 && key.year === "") ||
          all === 1 ||
          parseInt(
            hankaku2Zenkaku(
              key.downloadedData[item]["履修基準年度"].replace("年", "")
            )
          ) === key.year ||
          (key.year - 1 <= 1 &&
            parseInt(
              hankaku2Zenkaku(
                key.downloadedData[item]["履修基準年度"].replace("年", "")
              )
            ) ===
              key.year - 1) ||
          (key.year - 2 <= 1 &&
            parseInt(
              hankaku2Zenkaku(
                key.downloadedData[item]["履修基準年度"].replace("年", "")
              )
            ) ===
              key.year - 2) ||
          (key.year - 3 <= 1 &&
            parseInt(
              hankaku2Zenkaku(
                key.downloadedData[item]["履修基準年度"].replace("年", "")
              )
            ) ===
              key.year - 3)
        ) {
          all = 0;
          if (key.ad === 0) {
            all = 1;
          }
          if (
            (key.ad !== 0 && key.ad === "") ||
            all === 1 ||
            key.downloadedData[item]["管理部署"] + 1 === key.ad
          ) {
            all = 0;
            if (key.term === 0) {
              all = 1;
            }
            if (
              (key.term !== 0 && key.term === "") ||
              all === 1 ||
              key.downloadedData[item]["開講期"] + 1 === key.term
            ) {
              let i = 1;
              let l = 1;
              let check = true;
              while (key.downloadedData[item][`評価${l}`] !== undefined) {
                check = false;
                all = 0;
                if (key.score === 0) {
                  all = 1;
                }
                if (
                  (key.score !== 0 && key.score === "") ||
                  all === 1 ||
                  key.downloadedData[item][`評価${l}`] + 1 === key.score
                ) {
                  check = true;
                  break;
                }
                l++;
              }
              if (check === true) {
                while (key.downloadedData[item][`時限${i}`] !== undefined) {
                  all = 0;
                  if (key.day === 0) {
                    all = 1;
                  }
                  if (
                    key.day === "" ||
                    all === 1 ||
                    key.downloadedData[item][`時限${i}`] + 1 === key.day
                  ) {
                    key.downloadedData[item]["id"] = item;
                    key.downloadedData[item]["campasA"] =
                      campas_data[key.downloadedData[item]["campas"]];
                    key.downloadedData[item]["管理部署A"] =
                      ad_data[key.downloadedData[item]["管理部署"]];
                    key.downloadedData[item]["開講期A"] =
                      term_data[key.downloadedData[item]["開講期"]];
                    let test = JSON.parse(
                      JSON.stringify([key.downloadedData[item]])
                    );
                    if (test[0]["name"].lastIndexOf("／") !== -1) {
                      test[0]["name"] = test[0]["name"].substring(
                        0,
                        test[0]["name"].lastIndexOf("／")
                      );
                    }
                    if (
                      window.matchMedia &&
                      window.matchMedia("(max-device-width: 640px)").matches
                    ) {
                      result.push(ForsumartPhone(test[0]));
                      break;
                    } else {
                      result.push(ForPC(test[0], key.score));
                      break;
                      // result.push(key.downloadedData[item]);
                    }
                  }
                  i++;
                }
              }
              // if (i === 9999) break;
            }
          }
        }
      }
    }
    // }
  }
}
  // console.log(result);
  if (!result || result.length === 0) return [{ subject: "not found" }];
  if (result[0] === undefined) result = [result];
  return result;
}

export default function SearchResult(props) {
  // const tableRef = React.createRef();
  const classes = useStyles();
  const location = useLocation();
  const history = useHistory();
  const [rows, setRows] = React.useState([{}]);
  const [page, setPage] = React.useState(0);
  const [rowsPerPage, setRowsPerPage] = React.useState(100);
  const [order, setOrder] = React.useState("asc");
  const [orderBy, setOrderBy] = React.useState("calories");
  const onPageChange = (event, newPage) => {
    setPage(newPage);
    window.scrollTo(0, 0);
  };
  const handleRequestSort = (event, property) => {
    const isAsc = orderBy === property && order === "asc";
    setOrder(isAsc ? "desc" : "asc");
    setOrderBy(property);
  };
  const handleChangeRowsPerPage = (event) => {
    setRowsPerPage(event.target.value);
    setPage(0);
    window.scrollTo(0, 0);
  };
  const createSortHandler = (property) => (event) => {
    handleRequestSort(event, property);
  };
  useEffect(() => {
    if (rows[0].length === undefined) {
      if (location.state !== undefined) {
        let tosendData = location.state;
        if (tosendData["downloadedData"] === null) {
          tosendData["downloadedData"] = props.data;
        }
        setRows(SearchEngine(tosendData));
        setPage(0);
      } else {
        if (props.ad === undefined) {
          history.push("/");
          window.location.reload();
        } else {
          setRows(SearchEngine(props));
        }
      }
    }
  }, [location.state, history, props]);
  // console.log(rows);
  if (
    window.matchMedia &&
    window.matchMedia("(max-device-width: 640px)").matches
  ) {
    window.scrollTo(0, 700);
  }
  return (
    <div style={{ height: "200%", width: "100%", marginBottom: "5rem" }}>
      {/* <Alert variant="filled" severity="error" className={classes.error}>
        授業形態が「オンデマンドＢ型オンライン授業(時間割なし)」の場合でもシラバスに曜日,時限が記載されている場合は
        <u>時間割あり扱い</u>になります。
        そのため、授業は重複すれば取れなくなります。ご注意ください。
      </Alert> */}
      <Box mb={4} mt={2}>
        {props.ad === undefined && location.state === undefined ? (
          <div>ネットワークエラー</div>
        ) : props.ad === undefined ? (
          <SearchForm
            all={location.state.all}
            campas={location.state.campas}
            term={location.state.term}
            ad={location.state.ad}
            day={location.state.day}
            data={location.state.downloadedData ?? props.data}
            score={location.state.score}
            year={location.state.year}
            howto={location.state.howto}
            short={true}
            only={false}
          />
        ) : (
          <SearchForm
            all={props.all}
            campas={props.campas}
            term={props.term}
            ad={props.ad}
            day={props.day}
            data={props.downloadedData ?? props.data}
            score={props.score}
            year={props.year}
            howto={props.howto}
            short={true}
            only={true}
          />
        )}
      </Box>
      <TableContainer className={classes.container}>
        <Table
          stickyHeader
          aria-label="sticky table"
          size="small"
          className={classes.bc}
        >
          <caption>
            稀にですが該当する教科が存在しても結果が表示されないバグが確認されています。もし結果が表示されない場合はお手数ですが
            <strong>リロード(サイトの再読み込み)</strong>
            をお願いします。それでも解決しない場合は
            <a href="https://kgu-syllabus.com/search">こちら</a>
            から再度検索ください。
            検索しても何も出てこなかったら検索にマッチする授業がありませんでした。授業の名称と先生の名前で検索していますので、キーワード、検索条件を再度確認ください。本サイトはスマホよりパソコンで見た方が見やすいかと思います。
            また、SafariやGoogle
            Chromeを使用してください。それでも厳しい場合は、左下の赤いチャットのマークから匿名で報告できますので、ご意見をお寄せください。
          </caption>
          <TableHead>
            <TableRow>
              {columns.map((column, index) => (
                <TableCell
                  key={column.id}
                  align={column.align}
                  className={classes.bbc}
                  style={{ width: column.width }}
                  sortDirection={orderBy === column.id ? order : false}
                >
                  <TableSortLabel
                    key={index}
                    active={orderBy === column.id}
                    direction={orderBy === column.id ? order : "asc"}
                    onClick={createSortHandler(column.id)}
                  >
                    {column.headerName}
                    {orderBy === column.id ? (
                      <span className={classes.visuallyHidden} key={index}>
                        {order === "desc"
                          ? "sorted descending"
                          : "sorted ascending"}
                      </span>
                    ) : null}
                  </TableSortLabel>
                </TableCell>
              ))}
            </TableRow>
          </TableHead>
          <TableBody>
            {stableSort(rows, getComparator(order, orderBy))
              .slice(page * rowsPerPage, page * rowsPerPage + rowsPerPage)
              .map((row) => {
                return (
                  <TableRow hover role="checkbox" tabIndex={-1} key={row.id}>
                    {columns.map((column) => {
                      const value = row[column.field];
                      return (
                        <TableCell
                          size="small"
                          key={column.id}
                          className={classes.bbc}
                          align={column.align}
                          onClick={() => {
                            window.scrollTo(0, 0);
                            history.push(`/subject/${row.id}`);
                          }}
                        >
                          {value}
                        </TableCell>
                      );
                    })}
                  </TableRow>
                );
              })}
          </TableBody>
          <TableFooter>
            <TableRow>
              <Hidden smUp>
                <TablePagination
                  rowsPerPageOptions={[]}
                  //  component="div"
                  count={rows.length}
                  rowsPerPage={rowsPerPage}
                  page={page}
                  //  className={classes.ac}
                  onChangePage={onPageChange}
                  onPageChange={onPageChange}
                  onChangeRowsPerPage={handleChangeRowsPerPage}
                  ActionsComponent={TablePaginationActions}
                />
              </Hidden>
              <Hidden smDown>
                <TablePagination
                  rowsPerPageOptions={[10, 25, 100, 1000]}
                  count={rows.length}
                  rowsPerPage={rowsPerPage}
                  page={page}
                  className={classes.ac}
                  SelectProps={{
                    inputProps: { "aria-label": "1ページ" },
                    native: true,
                  }}
                  // labelRowsPerPage='1ページ'
                  onPageChange={onPageChange}
                  onChangePage={onPageChange}
                  onChangeRowsPerPage={handleChangeRowsPerPage}
                  ActionsComponent={TablePaginationActions}
                />
              </Hidden>
            </TableRow>
          </TableFooter>
        </Table>
      </TableContainer>
    </div>
  );
}
