import "./App.css";
import Typography from "@material-ui/core/Typography";
import { Box } from "@material-ui/core";
import { makeStyles } from "@material-ui/core/styles";
import Grid from "@material-ui/core/Grid";
import React from "react";
import Skeleton from "@material-ui/lab/Skeleton";

const useStyles = makeStyles((theme) => ({
  grid: {
    marginTop: "8px",
    [theme.breakpoints.down("xs")]: {
      fontSize: "1.2em",
      background: "#5fc2f5",
      padding: "4px",
      textAlign: "center",
      fontWeight: "600!imporntant",
      letterSpacing: "0.05em",
      color: "#FFF!important",
    },
  },
  login: {
    float: "right",
    marginRight: theme.spacing(4),
    display: "flex",
    position: "absolute",
    right: "0px",
    color: "white",
  },
  gridmain: {
    [theme.breakpoints.down("xs")]: {
      margin: "2em 0",
      background: "#f1f1f1",
      boxShadow: "0 2px 4px rgba(0, 0, 0, 0.22)",
    },
  },
  p: {
    [theme.breakpoints.down("xs")]: {
      padding: "15px 20px",
      margin: "0",
      textAlign: "center",
    },
  },
  white: {
    [theme.breakpoints.down("xs")]: {
      color: "#FFF!important",
      fontWeight: "600!important",
      textAlign: "center",
    },
  },
  red: {
    color: "#ed5050!important",
    [theme.breakpoints.down("xs")]: {
      color: "#ed5050!important",
      fontWeight: "600!important",
      textAlign: "center",
    },
  },
  black: {
    [theme.breakpoints.down("xs")]: {
      color: "#000!important",
    },
  },
}));

export default function Subjectcontent(props) {
  const classes = useStyles();
  return (
    <Box mt={{ xs: 2, md: 4 }}>
      {typeof props.content !== "undefined" ? (
        <Grid
          container
          direction="row"
          justifyContent="flex-start"
          alignItems="center"
          spacing={0}
          className={classes.gridmain}
        >
          <Grid item xs={12} md={2} mt={4} className={classes.grid}>
            <Typography
              variant="body1"
              component="body1"
              className={classes.white}
            >
              {props.title}
            </Typography>
          </Grid>
          {props.subcontent ? (
            <Grid item xs={12} md={5} className={classes.p}>
              <Typography
                variant={props.size}
                component="h2"
                display="inline"
                className={classes.black}
              >
                {props.data ? props.content : <Skeleton />}
              </Typography>
            </Grid>
          ) : (
            <Grid item xs={12} md={10} className={classes.p}>
              <Typography
                variant={props.size}
                component="h2"
                display="inline"
                className={props.isred? classes.red : classes.black}
              >
                {props.data ? props.content : <Skeleton />}
              </Typography>
            </Grid>
          )}
          {props.subcontent ? (
            <Grid item xs={12} md={5} className={classes.p}>
              <Typography
                variant={props.size}
                component="h2"
                display="inline"
                className={classes.black}
              >
                {props.data ? props.subcontent : <Skeleton />}
              </Typography>
            </Grid>
          ) : null}
        </Grid>
      ) : null}
    </Box>
  );
}
