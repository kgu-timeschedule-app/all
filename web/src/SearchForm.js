import "./App.css";
import { Box } from "@material-ui/core";
import { makeStyles } from "@material-ui/core/styles";
import OutlinedInput from "@material-ui/core/OutlinedInput";
import Button from "@material-ui/core/Button";
import Grid from "@material-ui/core/Grid";
import SchoolIcon from "@material-ui/icons/School";
import AccessTimeIcon from "@material-ui/icons/AccessTime";
import AccountBalanceIcon from "@material-ui/icons/AccountBalance";
import BusinessIcon from "@material-ui/icons/Business";
import { useHistory } from "react-router-dom";
import React, { useState, useEffect } from "react";
import TextField from "@material-ui/core/TextField";
import MenuItem from "@material-ui/core/MenuItem";
import Select from "@material-ui/core/Select";
import FormControl from "@material-ui/core/FormControl";
import Typography from "@material-ui/core/Typography";
import Card from "@material-ui/core/Card";
import SearchIcon from "@material-ui/icons/Search";

const useStyles = makeStyles((theme) => ({
  panel: {
    backgroundColor: "#F4F4F4",
    borderRadius: "16px!important",
    padding: "24px",
    paddingBottom: "56px",
  },
  panel2: {
    backgroundColor: "#F4F4F4",
    borderRadius: "16px!important",
    padding: "8px",
  },
  textfield: {
    backgroundColor: "#FFFFFF",
    borderRadius: "16px!important",
    marginTop: "0",
    marginBottom: "0",
  },
  bg_img: {
    backgroundImage: `url(${process.env.PUBLIC_URL}/search_img.jpg)`,
    height: "80vh",
    backgroundRepeat: "no-repeat",
    backgroundPosition: "center 0",
  },
  search_button: {
    paddingRight: "40px",
    paddingLeft: "40px",
    paddingTop: "8px",
    paddingBottom: "8px",
    color: "white",
  },
  white: {
    color: "white",
    padding: "5px",
  },
  button: {
    position: "absolute",
    bottom: "-35px",
    right: "0",
    margin: "auto",
    left: "0px",
  },
  form: {
    position: "relative",
  },
  search_icons: {
    paddingRight: "9px",
    verticalAlign: "sub",
    //  paddingBottom: "1px"
  },
  exSearch: {
    position: "fixed",
    bottom: "0",
    left: "0",
    width: "100vw"
  },
  exbtn: {
    width: "100%",
  }
}));

function Searching(
  keyword,
  history,
  data,
  campas_data,
  term_data,
  ad_data,
  day_data,
  ad,
  cp,
  time,
  term,
  year,
  score,
  howto
) {
  keyword.preventDefault();
  window.scrollTo(0, 0);
  history.push({
    pathname: "/searchResult",
    state: {
      all: keyword.target[0].value,
      campas: cp,
      term: term,
      ad: ad,
      day: time,
      score: score,
      year: year,
      howto: howto,
      downloadedData: data,
    },
  });
}

export default function SearchForm(props) {
  const classes = useStyles();
  const history = useHistory();
  const [autoComp, setAutocomp] = useState([]);
  let campas_data = [
    "すべて",
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
    "すべて",
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
    "すべて",
    "月曜１時限／Monday 1",
    "月曜２時限／Monday 2",
    "月曜３時限／Monday 3",
    "月曜４時限／Monday 4",
    "月曜５時限／Monday 5",
    "月曜６時限／Monday 6",
    "月曜７時限／Monday 7",
    "火曜１時限／Tuesday 1",
    "火曜２時限／Tuesday 2",
    "火曜３時限／Tuesday 3",
    "火曜４時限／Tuesday 4",
    "火曜５時限／Tuesday 5",
    "火曜６時限／Tuesday 6",
    "火曜７時限／Tuesday 7",
    "水曜１時限／Wednesday 1",
    "水曜２時限／Wednesday 2",
    "水曜３時限／Wednesday 3",
    "水曜４時限／Wednesday 4",
    "水曜５時限／Wednesday 5",
    "水曜６時限／Wednesday 6",
    "水曜７時限／Wednesday 7",
    "木曜１時限／Thursday 1",
    "木曜２時限／Thursday 2",
    "木曜３時限／Thursday 3",
    "木曜４時限／Thursday 4",
    "木曜５時限／Thursday 5",
    "木曜６時限／Thursday 6",
    "木曜７時限／Thursday 7",
    "金曜１時限／Friday 1",
    "金曜２時限／Friday 2",
    "金曜３時限／Friday 3",
    "金曜４時限／Friday 4",
    "金曜５時限／Friday 5",
    "金曜６時限／Friday 6",
    "金曜７時限／Friday 7",
    "土曜１時限／Saturday 1",
    "土曜２時限／Saturday 2",
    "土曜３時限／Saturday 3",
    " 土曜４時限／Saturday 4",
    "土曜５時限／Saturday 5",
    "土曜６時限／Saturday 6",
    "土曜７時限／Saturday 7",
    "日曜１時限／Sunday 1",
    "日曜２時限／Sunday 2",
    "日曜３時限／Sunday 3",
    "日曜４時限／Sunday 4",
    "日曜５時限／Sunday 5",
    "日曜６時限／Sunday 6",
    "‐／-",
    "集中・その他／Concentration/Other",
  ];
  let grade_year = [
    "すべて",
    "1年",
    "2年以下",
    "3年以下",
  ]

  let term_data = [
    "すべて",
    "通年／Year Round",
    "春学期／Spring",
    "秋学期／Fall<=======「秋学期」はこっち",
    "春学期前半／Spring (1st Half)",
    "春学期後半／Spring (2nd Half)",
    "秋学期前半／Fall (1st Half) ※「秋学期」とは別です。",
    "秋学期後半／Fall (2nd Half) ※「秋学期」とは別です。",
    "通年集中／Intensive (Year Round)",
    "春学期集中／Intensive (Spring)",
    "秋学期集中／Intensive (Fall)",
    "春学期前半集中／Intensive (Spring 1st Half)",
    "春学期後半集中／Intensive (Spring 2nd Half)",
    "秋学期前半集中／Intensive (Fall 1st Half)",
    "秋学期後半集中／Intensive (Fall 2nd Half)",
  ];

  let score_data = [
    "すべて",
    "「定期試験」を含む",
    "「定期試験に代わるリポート」を含む",
    "「授業中試験」を含む",
    "「平常リポート」を含む",
    "「プレゼンテーション, 発表」を含む",
    "「授業への参加度」を含む",
    "「その他」を含む",
    "「授業外学修課題」を含む",
    "「論文」を含む",
    "「実技, 実験」を含む"
  ];

  let howto_data = [
    "すべて",
    "「本登録」を含む",
    "「予備登録」を含む",
    "「申込科目」を含む",
  ]

  let [time, setTime] = useState(!props.day ? 0 : props.day);
  let [term, setTerm] = useState(!props.term ? 0 : props.term);
  let [ad, setAd] = useState(!props.ad ? 0 : props.ad);
  let [year, setYear] = useState(!props.year ? 0 : props.year);
  let [score, setScore] = useState(!props.score ? 0 : props.score);
  let [cp, setCampas] = useState(!props.campas ? 0 : props.campas);
  let [howto, setHowto]  = useState(!props.howto ? 0 : props.howto);
  const handleChangeTime = (event) => {
    setTime(event.target.value);
  };
  const handleChangeScore = (event) => {
    setScore(event.target.value);
  };
  const handleChangeHowto = (event) => {
    setHowto(event.target.value);
  };
  const handleChangeYear = (event) => {
    setYear(event.target.value);
  };
  const handleChangeTerm = (event) => {
    setTerm(event.target.value);
  };
  const handleChangeAd = (event) => {
    setAd(event.target.value);
  };
  const handleChangeCp = (event) => {
    event.preventDefault();
    setCampas(event.target.value);
  };

  function RealtimeSearch(keyword, data) {
    // chrome が重くなるため廃止
    let result = new Set();
    let i = 0;
    if (!data){
      return ;
    }
    let subj = ["担当者", "name"];
    for (var item in data) {
      for (var items in subj) {
        if (isNaN(data[item][subj[items]]) && data[item][subj[items]].indexOf(keyword) !== -1) {
          result.add(`${subj[items].replace("name","教科名")},${data[item][subj[items]]}`);
          i++;
          break;
        }
        if (i >= 5) break;
      }
      if (i >= 5) break;
    }
    if (!result) {
      return;
    } else if (result[0] === undefined) {
      result = [result];
    }
    setAutocomp(result);
    return ;
  }
  useEffect(() => {
    document.getElementById("search").autocomplete = true;
    document.getElementById("search").setAttribute("list", "mylist");
  });
  if (props.short === false) {
    return (
      <form
        className={classes.form}
        onSubmit={(e) =>
          Searching(
            e,
            history,
            props.data,
            campas_data,
            term_data,
            ad_data,
            day_data,
            ad,
            cp,
            time,
            term,
            year,
            score,
            howto
          )
        }
      >
        <Card className={classes.panel}>
          <div>
            <Typography>教科名、担当者名(空白なし)のどちらか</Typography>
            <TextField
              label=""
              variant="outlined"
              className={classes.textfield}
              id="search"
              fullWidth
              labelwidth={0}
              defaultValue={props.all}
              placeholder="指定なし"
              onClick={(event) => {
                event.stopPropagation();
              }}
              onFocus={(event) => {event.stopPropagation();
                RealtimeSearch(event.target.value, props.data);}}
              onChange={(event) =>
                RealtimeSearch(event.target.value, props.data)
              }
              inputProps={{ "data-hj-allow": true }}
            />
            <datalist id="mylist">
              {(() => {
                if (!autoComp[0]) return null;
                let result = [];
                var setIter = autoComp[0].values();
                let i = 0;
                while (i++ < autoComp[0].size) {
                  let value = setIter.next().value;
                  result.push(
                    <option value={value.split(",")[1].replace("【", " 【")}>
                      {value.split(",")[0]}
                    </option>
                  );
                }
                return <div>{result}</div>;
              })()}
            </datalist>
            <Grid container spacing={2}>
              <Grid item xs={12} sm={6}>
                <Typography> キャンパス名</Typography>
                <FormControl fullWidth>
                   <Select
                    displayEmpty
                    labelId="day_label"
                    id="day"
                    className={classes.textfield}
                    labelwidth={0}
                    placeholder="キャンパス"
                    fullWidth
                    value={cp}
                    onChange={handleChangeCp}
                    variant="outlined"
                    label=" キャンパス名"
                    input={
                      <OutlinedInput
                        id="campas"
                        fullWidth
                        className={classes.textfield}
                        labelwidth={0}
                        startAdornment={
                          <Box mx={1}>
                            <SchoolIcon></SchoolIcon>
                          </Box>
                        }
                        placeholder=" Enter a Campas Name"
                      />
                    }
                  >
                    {campas_data.map((value, index) => {
                      return (
                        <MenuItem value={index} key={index}>
                          {value}
                        </MenuItem>
                      );
                    })}
                  </Select>
                </FormControl>
              </Grid>
              <Grid item xs={12} sm={6}>
                <Typography>学期</Typography>
                <FormControl fullWidth>
                  {/* <InputLabel id="day_label">Age</InputLabel> */}
                  <Select
                    displayEmpty
                    labelId="day_label"
                    id="day"
                    className={classes.textfield}
                    labelwidth={0}
                    placeholder="Campas"
                    fullWidth
                    value={term}
                    onChange={handleChangeTerm}
                    variant="outlined"
                    label=" Select a Term"
                    input={
                      <OutlinedInput
                        id="term"
                        fullWidth
                        className={classes.textfield}
                        labelwidth={0}
                        startAdornment={
                          <Box mx={1}>
                            <BusinessIcon></BusinessIcon>
                          </Box>
                        }
                        placeholder=" Term"
                      />
                    }
                  >
                    {term_data.map((value, index) => {
                      if (index === 2) {
                        return (
                          <MenuItem
                            value={index}
                            key={index}
                            style={{ fontWeight: "bold" }}
                          >
                            {value}
                          </MenuItem>
                        );
                      }
                      return (
                        <MenuItem value={index} key={index}>
                          {value}
                        </MenuItem>
                      );
                    })}
                  </Select>
                </FormControl>
              </Grid>
              <Grid item xs={12} sm={6}>
                <FormControl fullWidth>
                  {/* <InputLabel id="day_label">Age</InputLabel> */}
                  <Typography>学部、学科</Typography>
                  <Select
                    displayEmpty
                    labelId="day_label"
                    id="day"
                    className={classes.textfield}
                    labelwidth={0}
                    placeholder="Administrative Dept."
                    fullWidth
                    value={ad}
                    onChange={handleChangeAd}
                    variant="outlined"
                    label="Administrative Dept."
                    input={
                      <OutlinedInput
                        id="ad"
                        fullWidth
                        className={classes.textfield}
                        labelwidth={0}
                        placeholder="Administrative Dept."
                        startAdornment={
                          <Box mx={1}>
                            <AccountBalanceIcon></AccountBalanceIcon>
                          </Box>
                        }
                      />
                    }
                  >
                    {ad_data.map((value, index) => {
                      return (
                        <MenuItem value={index} key={index}>
                          {value}
                        </MenuItem>
                      );
                    })}
                  </Select>
                </FormControl>
              </Grid>
              <Grid item xs={12} sm={6}>
                <Typography>曜日 / 時限</Typography>
                <Select
                  displayEmpty
                  id="day"
                  className={classes.textfield}
                  labelwidth={0}
                  placeholder="Day and Period"
                  fullWidth
                  value={time}
                  onChange={handleChangeTime}
                  variant="outlined"
                  label="Day and Period"
                  input={
                    <OutlinedInput
                      id="day"
                      fullWidth
                      className={classes.textfield}
                      labelwidth={0}
                      startAdornment={
                        <Box mx={1}>
                          <AccessTimeIcon></AccessTimeIcon>
                        </Box>
                      }
                      placeholder=" Day and Period"
                    />
                  }
                >
                  {day_data.map((value, index) => {
                    return (
                      <MenuItem value={index} key={index}>
                        {value}
                      </MenuItem>
                    );
                  })}
                </Select>
              </Grid>
              <Grid item xs={12} sm={6}>
                  <Typography>履修可能学年</Typography>
                  <Select
                    displayEmpty
                    id="year"
                    className={classes.textfield}
                    labelwidth={0}
                    placeholder="year"
                    fullWidth
                    value={year}
                    onChange={handleChangeYear}
                    variant="outlined"
                    label="year"
                    input={
                      <OutlinedInput
                        id="year"
                        fullWidth
                        className={classes.textfield}
                        labelwidth={0}
                        startAdornment={
                          <Box mx={1}>
                            <AccessTimeIcon></AccessTimeIcon>
                          </Box>
                        }
                        placeholder=" Year"
                      />
                    }
                  >
                    {grade_year.map((value, index) => {
                      return (
                        <MenuItem value={index} key={index}>
                          {value}
                        </MenuItem>
                      );
                    })}
                  </Select>
                </Grid>

              <Grid item xs={12} sm={6}>
                <Typography>成績評価方法</Typography>
                <Select
                  displayEmpty
                  id="grade"
                  className={classes.textfield}
                  labelwidth={0}
                  placeholder="Grade"
                  fullWidth
                  value={score}
                  onChange={handleChangeScore}
                  variant="outlined"
                  label="Grade"
                  input={
                    <OutlinedInput
                      id="day"
                      fullWidth
                      className={classes.textfield}
                      labelwidth={0}
                      startAdornment={
                        <Box mx={1}>
                          <AccessTimeIcon></AccessTimeIcon>
                        </Box>
                      }
                      placeholder=" Grade"
                    />
                  }
                >
                  {score_data.map((value, index) => {
                    return (
                      <MenuItem value={index} key={index}>
                        {value}
                      </MenuItem>
                    );
                  })}
                </Select>
              </Grid>

              <Grid item xs={12} sm={6}>
                <Typography>履修登録方法</Typography>
                <Select
                  displayEmpty
                  id="howto"
                  className={classes.textfield}
                  labelwidth={0}
                  placeholder="howto"
                  fullWidth
                  value={howto}
                  onChange={handleChangeHowto}
                  variant="outlined"
                  label="履修登録方法"
                  input={
                    <OutlinedInput
                      id="howto"
                      fullWidth
                      className={classes.textfield}
                      labelwidth={0}
                      startAdornment={
                        <Box mx={1}>
                          <AccessTimeIcon></AccessTimeIcon>
                        </Box>
                      }
                      placeholder=" 履修登録方法"
                    />
                  }
                >
                  {howto_data.map((value, index) => {
                    return (
                      <MenuItem value={index} key={index}>
                        {value}
                      </MenuItem>
                    );
                  })}
                </Select>
              </Grid>

              <Box mx="auto" my={2} className={classes.button}>
                <Button
                  variant="contained"
                  color="primary"
                  type="submit"
                  value="Submit"
                  size="large"
                  onClick={(event) => event.stopPropagation()}
                  onFocus={(event) => event.stopPropagation()}
                >
                  <Typography variant="h5" className={classes.search_button}>
                    <SearchIcon
                      style={{ fontSize: 27 }}
                      className={classes.search_icons}
                    />
                    授業を検索
                  </Typography>
                </Button>
              </Box>
            </Grid>
          </div>
        </Card>
        <div class={classes.exSearch}>
        <Button
        className={classes.exbtn}
                  variant="contained"
                  color="primary"
                  type="submit"
                  value="Submit"
                  size="small"
                  onClick={(event) => event.stopPropagation()}
                  onFocus={(event) => event.stopPropagation()}
                >
                  <Typography variant="h5" className={classes.search_button}>
                    この条件で授業を検索
                  </Typography>
                </Button>
                </div>
      </form>
    );
  } else {
    if (props.only) {
      return (
        <form
          className={classes.form}
          onSubmit={(e) =>
            Searching(
              e,
              history,
              props.data,
              campas_data,
              term_data,
              ad_data,
              day_data,
              ad,
              cp,
              time,
              term,
              year,
              score,
              howto
            )
          }
        >
          <Card className={classes.panel2}>
            <div>
              <Grid container spacing={2}>
                <Grid item xs={12} sm={7}>
                  <Typography>検索内容</Typography>
                  <TextField
                    label="キーワード"
                    variant="outlined"
                    className={classes.textfield}
                    id="search"
                    fullWidth
                    labelwidth={0}
                    defaultValue={props.all}
                    placeholder=""
                    onClick={(event) => {
                      event.stopPropagation();
                    }}
                    onFocus={(event) => {event.stopPropagation();
                      RealtimeSearch(event.target.value, props.data);}}
                    inputProps={{ "data-hj-allow": true }}
                    onChange={(event) =>
                      RealtimeSearch(event.target.value, props.data)
                    }
                  />
                  <datalist id="mylist">
                    {(() => {
                      if (!autoComp[0]) return null;
                      let result = [];
                      var setIter = autoComp[0].values();
                      let i = 0;
                      while (i++ < autoComp[0].size) {
                        let value = setIter.next().value;
                        result.push(
                          <option
                            value={value.split(",")[1].replace("【", " 【")}
                          >
                            {value.split(",")[0]}
                          </option>
                        );
                      }
                      return <div>{result}</div>;
                    })()}
                  </datalist>
                </Grid>
                <Grid item xs={12} sm={3}>
                  <Typography>Period</Typography>
                  <Select
                    displayEmpty
                    id="day"
                    className={classes.textfield}
                    labelwidth={0}
                    placeholder="Day and Period"
                    fullWidth
                    value={time}
                    onChange={handleChangeTime}
                    variant="outlined"
                    label="Day and Period"
                    input={
                      <OutlinedInput
                        id="day"
                        fullWidth
                        className={classes.textfield}
                        labelwidth={0}
                        startAdornment={
                          <Box mx={1}>
                            <AccessTimeIcon></AccessTimeIcon>
                          </Box>
                        }
                        placeholder=" Day and Period"
                      />
                    }
                  >
                    {day_data.map((value, index) => {
                      return (
                        <MenuItem value={index} key={index}>
                          {value}
                        </MenuItem>
                      );
                    })}
                  </Select>
                </Grid>
                <Grid item xs={12} sm={3}>
                  <Typography>履修可能学年(β)</Typography>
                  <Select
                    displayEmpty
                    id="year"
                    className={classes.textfield}
                    labelwidth={0}
                    placeholder="year"
                    fullWidth
                    value={year}
                    onChange={handleChangeYear}
                    variant="outlined"
                    label="year"
                    input={
                      <OutlinedInput
                        id="year"
                        fullWidth
                        className={classes.textfield}
                        labelwidth={0}
                        startAdornment={
                          <Box mx={1}>
                            <AccessTimeIcon></AccessTimeIcon>
                          </Box>
                        }
                        placeholder=" Year"
                      />
                    }
                  >
                    {grade_year.map((value, index) => {
                      return (
                        <MenuItem value={index} key={index}>
                          {value}
                        </MenuItem>
                      );
                    })}
                  </Select>
                </Grid>
                <Grid item xs={12} sm={3}>
                  <Typography>成績評価方法</Typography>
                  <Select
                    displayEmpty
                    id="grade"
                    className={classes.textfield}
                    labelwidth={0}
                    placeholder="Grade"
                    fullWidth
                    value={score}
                    onChange={handleChangeScore}
                    variant="outlined"
                    label="Grade"
                    input={
                      <OutlinedInput
                        id="day"
                        fullWidth
                        className={classes.textfield}
                        labelwidth={0}
                        startAdornment={
                          <Box mx={1}>
                            <AccessTimeIcon></AccessTimeIcon>
                          </Box>
                        }
                        placeholder=" Grade"
                      />
                    }
                  >
                    {score_data.map((value, index) => {
                      return (
                        <MenuItem value={index} key={index}>
                          {value}
                        </MenuItem>
                      );
                    })}
                  </Select>
                </Grid>
                <Grid item xs={12} sm={3}>
                  <Typography>成績評価方法</Typography>
                  <Select
                    displayEmpty
                    id="howto"
                    className={classes.textfield}
                    labelwidth={0}
                    placeholder="履修登録方法"
                    fullWidth
                    value={howto}
                    onChange={handleChangeHowto}
                    variant="outlined"
                    label="howto"
                    input={
                      <OutlinedInput
                        id="howto"
                        fullWidth
                        className={classes.textfield}
                        labelwidth={0}
                        startAdornment={
                          <Box mx={1}>
                            <AccessTimeIcon></AccessTimeIcon>
                          </Box>
                        }
                        placeholder=" 履修登録方法"
                      />
                    }
                  >
                    {howto_data.map((value, index) => {
                      return (
                        <MenuItem value={index} key={index}>
                          {value}
                        </MenuItem>
                      );
                    })}
                  </Select>
                </Grid>
                <Grid item xs={12} sm={2}>
                  <Typography>Search</Typography>
                  <Button
                    variant="contained"
                    color="primary"
                    type="submit"
                    value="Submit"
                    size="large"
                    onClick={(event) => event.stopPropagation()}
                    onFocus={(event) => event.stopPropagation()}
                  >
                    <Typography className={classes.white} variant="body2">
                      検索
                    </Typography>
                  </Button>
                </Grid>
              </Grid>
            </div>
          </Card>
        </form>
      );
    } else {
      return (
        <form
          className={classes.form}
          onSubmit={(e) =>
            Searching(
              e,
              history,
              props.data,
              campas_data,
              term_data,
              ad_data,
              day_data,
              ad,
              cp,
              time,
              term,
              year,
              score,
              howto
            )
          }
        >
          <Card className={classes.panel2}>
            <div>
              <Grid container spacing={2}>
                <Grid item xs={12} sm={8}>
                  <Typography>検索内容</Typography>
                  <TextField
                    label="キーワード"
                    variant="outlined"
                    className={classes.textfield}
                    id="search"
                    fullWidth
                    labelwidth={0}
                    defaultValue={props.all}
                    placeholder=""
                    onClick={(event) => {
                      event.stopPropagation();
                    }}
                    onFocus={(event) => {event.stopPropagation();
                      RealtimeSearch(event.target.value, props.data);}}
                    inputProps={{ "data-hj-allow": true }}
                    onChange={(event) =>
                      RealtimeSearch(event.target.value, props.data)
                    }
                  />
                  <datalist id="mylist">
                    {(() => {
                      if (!autoComp[0]) return null;
                      let result = [];
                      var setIter = autoComp[0].values();
                      let i = 0;
                      while (i++ < autoComp[0].size) {
                        let value = setIter.next().value;
                        result.push(
                          <option
                            value={value.split(",")[1].replace("【", " 【")}
                          >
                            {value.split(",")[0]}
                          </option>
                        );
                      }
                      return <div>{result}</div>;
                    })()}
                  </datalist>
                </Grid>
                <Grid item xs={12} sm={2}>
                  <Typography> キャンパス名</Typography>
                  <FormControl fullWidth>
                    {/* <InputLabel id="day_label">Age</InputLabel> */}
                    <Select
                      displayEmpty
                      labelId="day_label"
                      id="day"
                      className={classes.textfield}
                      labelwidth={0}
                      placeholder="Campas"
                      fullWidth
                      value={cp}
                      onChange={handleChangeCp}
                      variant="outlined"
                      label=" Select a Campas Name"
                      input={
                        <OutlinedInput
                          id="campas"
                          fullWidth
                          className={classes.textfield}
                          labelwidth={0}
                          startAdornment={
                            <Box mx={1}>
                              <SchoolIcon></SchoolIcon>
                            </Box>
                          }
                          placeholder=" Enter a Campas Name"
                        />
                      }
                    >
                      {campas_data.map((value, index) => {
                        return (
                          <MenuItem value={index} key={index}>
                            {value}
                          </MenuItem>
                        );
                      })}
                    </Select>
                  </FormControl>
                </Grid>
                <Grid item xs={12} sm={2}>
                  <Typography> 学期</Typography>
                  <FormControl fullWidth>
                    {/* <InputLabel id="day_label">Age</InputLabel> */}
                    <Select
                      displayEmpty
                      labelId="day_label"
                      id="day"
                      className={classes.textfield}
                      labelwidth={0}
                      placeholder="Campas"
                      fullWidth
                      value={term}
                      onChange={handleChangeTerm}
                      variant="outlined"
                      label=" Select a Term"
                      input={
                        <OutlinedInput
                          id="term"
                          fullWidth
                          className={classes.textfield}
                          labelwidth={0}
                          startAdornment={
                            <Box mx={1}>
                              <BusinessIcon></BusinessIcon>
                            </Box>
                          }
                          placeholder=" Term"
                        />
                      }
                    >
                      {term_data.map((value, index) => {
                        if (index === 2) {
                          return (
                            <MenuItem
                              value={index}
                              key={index}
                              style={{ fontWeight: "bold" }}
                            >
                              {value}
                            </MenuItem>
                          );
                        }
                        return (
                          <MenuItem value={index} key={index}>
                            {value}
                          </MenuItem>
                        );
                      })}
                    </Select>
                  </FormControl>
                </Grid>
                <Grid item xs={12} sm={2}>
                  <FormControl fullWidth>
                    {/* <InputLabel id="day_label">Age</InputLabel> */}
                    <Typography>学部, 学科, 研究科</Typography>
                    <Select
                      displayEmpty
                      labelId="day_label"
                      id="day"
                      className={classes.textfield}
                      labelwidth={0}
                      placeholder="Administrative Dept."
                      fullWidth
                      value={ad}
                      onChange={handleChangeAd}
                      variant="outlined"
                      label="Administrative Dept."
                      input={
                        <OutlinedInput
                          id="ad"
                          fullWidth
                          className={classes.textfield}
                          labelwidth={0}
                          placeholder="Administrative Dept."
                          startAdornment={
                            <Box mx={1}>
                              <AccountBalanceIcon></AccountBalanceIcon>
                            </Box>
                          }
                        />
                      }
                    >
                      {ad_data.map((value, index) => {
                        return (
                          <MenuItem value={index} key={index}>
                            {value}
                          </MenuItem>
                        );
                      })}
                    </Select>
                  </FormControl>
                </Grid>
                <Grid item xs={12} sm={2}>
                  <Typography>曜日 / 時限</Typography>
                  <Select
                    displayEmpty
                    id="day"
                    className={classes.textfield}
                    labelwidth={0}
                    placeholder="Day and Period"
                    fullWidth
                    value={time}
                    onChange={handleChangeTime}
                    variant="outlined"
                    label="Day and Period"
                    input={
                      <OutlinedInput
                        id="day"
                        fullWidth
                        className={classes.textfield}
                        labelwidth={0}
                        startAdornment={
                          <Box mx={1}>
                            <AccessTimeIcon></AccessTimeIcon>
                          </Box>
                        }
                        placeholder=" Day and Period"
                      />
                    }
                  >
                    {day_data.map((value, index) => {
                      return (
                        <MenuItem value={index} key={index}>
                          {value}
                        </MenuItem>
                      );
                    })}
                  </Select>
                </Grid>
                <Grid item xs={12} sm={2}>
                  <Typography>履修可能学年(β)</Typography>
                  <Select
                    displayEmpty
                    id="year"
                    className={classes.textfield}
                    labelwidth={0}
                    placeholder="year"
                    fullWidth
                    value={year}
                    onChange={handleChangeYear}
                    variant="outlined"
                    label="year"
                    input={
                      <OutlinedInput
                        id="year"
                        fullWidth
                        className={classes.textfield}
                        labelwidth={0}
                        startAdornment={
                          <Box mx={1}>
                            <AccessTimeIcon></AccessTimeIcon>
                          </Box>
                        }
                        placeholder=" Year"
                      />
                    }
                  >
                    {grade_year.map((value, index) => {
                      return (
                        <MenuItem value={index} key={index}>
                          {value}
                        </MenuItem>
                      );
                    })}
                  </Select>
                </Grid>
                <Grid item xs={12} sm={2}>
                  <Typography>成績評価方法</Typography>
                  <Select
                    displayEmpty
                    id="grade"
                    className={classes.textfield}
                    labelwidth={0}
                    placeholder="Grade"
                    fullWidth
                    value={score}
                    onChange={handleChangeScore}
                    variant="outlined"
                    label="Grade"
                    input={
                      <OutlinedInput
                        id="day"
                        fullWidth
                        className={classes.textfield}
                        labelwidth={0}
                        startAdornment={
                          <Box mx={1}>
                            <AccessTimeIcon></AccessTimeIcon>
                          </Box>
                        }
                        placeholder=" Grade"
                      />
                    }
                  >
                    {score_data.map((value, index) => {
                      return (
                        <MenuItem value={index} key={index}>
                          {value}
                        </MenuItem>
                      );
                    })}
                  </Select>
                </Grid>
                <Grid item xs={12} sm={2}>
                  <Typography>履修登録方法</Typography>
                  <Select
                    displayEmpty
                    id="howto"
                    className={classes.textfield}
                    labelwidth={0}
                    placeholder="howto"
                    fullWidth
                    value={howto}
                    onChange={handleChangeHowto}
                    variant="outlined"
                    label="howto"
                    input={
                      <OutlinedInput
                        id="howto"
                        fullWidth
                        className={classes.textfield}
                        labelwidth={0}
                        startAdornment={
                          <Box mx={1}>
                            <AccessTimeIcon></AccessTimeIcon>
                          </Box>
                        }
                        placeholder=" howto"
                      />
                    }
                  >
                    {howto_data.map((value, index) => {
                      return (
                        <MenuItem value={index} key={index}>
                          {value}
                        </MenuItem>
                      );
                    })}
                  </Select>
                </Grid>
                <Grid item xs={12} sm={2}>
                  <Typography>Search</Typography>
                  <Button
                    variant="contained"
                    color="primary"
                    type="submit"
                    value="Submit"
                    size="large"
                    onClick={(event) => event.stopPropagation()}
                    onFocus={(event) => event.stopPropagation()}
                  >
                    <Typography className={classes.white} variant="body2">
                      検索
                    </Typography>
                  </Button>
                </Grid>
              </Grid>
            </div>
          </Card>
        </form>
      );
    }
  }
}
