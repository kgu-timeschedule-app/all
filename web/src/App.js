import "./App.css";
import Header from "./Header";
import Ad from "./Ad";
import Search from "./Search";
import SearchResult from "./SearchResult";
import Subject from "./Subject";
// import Schedule from "./Schedule";
import Privacy from "./Privacy";
import Main from "./Main";
// import ShowSchedule from "./ShowSchedule";
import NoMatch from "./NoMatch";
import { BrowserRouter as Router, Route, Switch, Redirect } from "react-router-dom";
import DataDownload from "./dataDownload";
import firebase from "./firebasec_conf";
import Allpages from "./Allpsges";
import Footer from "./Footer";
import "firebase/auth";
import * as Sentry from "@sentry/react";
import { BrowserTracing } from "@sentry/tracing";
import React, { useEffect, useState } from "react";

Sentry.init({
  dsn: "https://33467225b3344688bb31edca30f323b6@o4504382268178432.ingest.sentry.io/4504382289346560",
  integrations: [new BrowserTracing()],

  // Set tracesSampleRate to 1.0 to capture 100%
  // of transactions for performance monitoring.
  // We recommend adjusting this value in production
  tracesSampleRate: 1.0,
});

function App() {
  let [userid, setUser] = useState(null);
  let [data, setData] = useState({});
  let [loginalert, setLoginalert] = useState(false);

  useEffect(
    () =>
      firebase
        .auth()
        .onAuthStateChanged((user) =>
          user ? setUser(user) : setLoginalert(true)
        ),
    []
  );
  function RedirectWithStatus({ from, to, status }) {
    return (
      <Route
        render={({ staticContext }) => {
          // there is no `staticContext` on the client, so
          // we need to guard against that here
          if (staticContext) staticContext.status = status;
          return <Redirect from={from} to={to} />;
        }}
      />
    );
  }
  return (
    <Router>
      <Header user={userid} Pleaselogin={loginalert} />
      <Switch>
        <Route exact path="/">
        <DataDownload data={setData} value={data} />
          <Main />
          <Footer />
        </Route>
        <Route exact path="/allpages">
        <DataDownload data={setData} value={data} />
          <Allpages data={data} />
          <Footer />
        </Route>
        <Route exact path="/search">
        <DataDownload data={setData} value={data} />
          <Search data={data} />
          <Footer />
        </Route>
        <Route exact path="/searchResult">
        <DataDownload data={setData} value={data} />
          <SearchResult data={data} />
        </Route>
        <Route exact path="/ad/:id">
        <DataDownload data={setData} value={data} />
          <Ad data={data} />
        </Route>
        <Route exact path="/subject/:id">
          <Subject user={userid}/>
        </Route>
        <Route exact path="/privacy">
          <Privacy />
        </Route>
        {/* <Route
          exact
          path="/schedule"
          render={() =>
            userid ? <Schedule user={userid} /> : <Search data={data} />
          }
        ></Route>
        {/* <Route exact path="/schedulemake" component={Schedulemake}></Route> */}

        {/* <Route
          exact
          path="/schedule/:id"
          render={() => (userid ? <ShowSchedule /> : <Search data={data} />)}
        ></Route> */}
        <RedirectWithStatus path="*" component={NoMatch}/>
      </Switch>
    </Router>
  );
}

export default App;
