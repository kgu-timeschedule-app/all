import "./App.css";
import Typography from "@material-ui/core/Typography";
import { Box } from "@material-ui/core";
import { makeStyles } from "@material-ui/core/styles";
import Grid from "@material-ui/core/Grid";
import React from "react";

const useStyles = makeStyles((theme) => ({
  topimage: {
    width: "90vw",
    marginLeft: "10vw",
    position: "absolute",
    zIndex: "-1",
  },
  top: {
    width: "100vw",
    backgroundColor: "#000000ad",
    zIndex: "10",
  },
  text: {
    fontWeight: "700",
    color: "white",
    padding: "0",
  },
  sub: {
    color: "#5392F9",
  },
  tmp: {
    width: "100vw",
  },
  toptext: {
    paddingTop: "30vw",
  },
  bt: {
    marginLeft: "10px",
  },
  small: {
    color: "#5392F9",
    fontWeight: "700",
    fontSize: "24px",
  },
  small2: {
    color: "#5392F9",
    fontWeight: "700",
    fontSize: "24px",
    display: "block",
  },
  t2: {
    color: "#DDDDDD",
    fontWeight: "700",
  },
  t3: {
    color: "#3f9863",
    fontWeight: "700",
  },
  icon: {
    verticalAlign: "sub",
  },
  line: {
    width: "24%",
  },
  eximg: {
    width: "100%",
  },
}));

export default function Explain(props) {
  const classes = useStyles();
  return (
    <Box id={props.id} my={5} mx={3}>
      <Typography variant="body2" className={classes.small2} >
        {props.titleen}
      </Typography>
      <Box mt={1} mb={2}>
        <Typography variant="h4" component="h3">
          {props.title}
        </Typography>
        <Typography variant="body1">
          {props.discription}
        </Typography>
      </Box>
      <Grid container spacing={5}>
        <Grid item xs={12} sm={6}>
          {props.img1}
        </Grid>
        <Grid item xs={12} sm={6}>
          <Box mb={5}>
            <Typography
              variant="body2"
              className={classes.small2}
              component="h3"
            >
              STEP1
            </Typography>
            <Typography variant="h5" component="h3">
              {props.title1}
            </Typography>
            <Typography variant="body1">
              {props.discription1}
            </Typography>
          </Box>
        </Grid>
        {props.title2 ? (
          <Grid item xs={12} sm={6}>
            {props.img2}
          </Grid>
        ) : null}
        {props.title2 ? (
          <Grid item xs={12} sm={6}>
            <Box mb={5}>
              <Typography
                variant="body2"
                className={classes.small2}
              >
                STEP2
              </Typography>
              <Typography variant="h5" component="h3">
                {props.title2}
              </Typography>
              <Typography variant="body1">
                {props.discription2}
              </Typography>
            </Box>
          </Grid>
        ) : null}
        {props.title2 ? (
          <Grid item xs={12} sm={6}>
            {props.img3}
          </Grid>
        ) : null}
        {props.title2 ? (
          <Grid item xs={12} sm={6}>
            <Box mb={5}>
              <Typography
                variant="body2"
                className={classes.small2}
              >
               STEP3
              </Typography>
              <Typography variant="h5" component="h3">
                {props.title3}
              </Typography>
              <Typography variant="body1">
                {props.discription3}
              </Typography>
            </Box>
          </Grid>
        ) : null}
      </Grid>
    </Box>
  );
}
