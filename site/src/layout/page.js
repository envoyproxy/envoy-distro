
import React from 'react';

import exact from 'prop-types-exact';

import EnvoyDistroSiteHeader from './header';

import {EnvoyDistroSections} from '../home/section';

import Code from "./code";


function getCode (site, distro_name) {
    return `$ sudo apt install apt-transport-https ca-certificates curl gnupg2 software-properties-common
$ curl -sL '${site}/gpg' | sudo gpg --dearmor -o /usr/share/keyrings/envoy-keyring.gpg
$ echo "deb [arch=amd64 signed-by=/usr/share/keyrings/envoy-keyring.gpg] ${site} ${distro_name} main" | sudo tee /etc/apt/sources.list.d/envoy.list
$ apt-get update
`;
}

function getInstallCode (site, distro_name) {
    return `$ sudo apt install envoy`;
}

export class EnvoyDistroVersionSwitcher extends React.PureComponent {

    render () {
        return (
            <div>
              SWITCH VERSIONS...
            </div>);
    }
}

export class EnvoyDistroArchitectures extends React.PureComponent {

    render () {
        return (
            <div>
              amd64 | arm64
            </div>);
    }
}

export class EnvoyDistroVersions extends React.PureComponent {

    render () {
        const distro_name = this.props.distro.name;
        // const site = "http://localhost:8000";
        const site = "https://deploy-preview-1--infallible-ramanujan-e7fd8c.netlify.app";
        return (
            <div>
              <Code code={getCode(site, distro_name)} language="shell-session" />
              {this.props.distro.versions}
              {this.props.distro.versions.map((version, key) => {
                  return (
                      <Code code={getInstallCode(site, distro_name)} language="shell-session" />
                  );
              })}
            </div>);
    }
}

export class EnvoyDistroDistro extends React.PureComponent {

    render () {
        return (
            <div>
              <div>
                distro: {this.props.distro.name}
              </div>
              <EnvoyDistroVersions distro={this.props.distro} />
            </div>);
    }
}

export class EnvoyDistroDistros extends React.PureComponent {
    distros = [
        {name: "buster",
         title: "Debian Buster",
         versions: ["latest", "1.19", "1.18"]},
        {name: "bullseye",
         title: "Debian Bullseye",
         versions: ["latest", "1.19", "1.18"]},
        {name: "redhat-7",
         title: "Redhat 7",
         versions: ["latest", "1.19", "1.18"]}];

    get sections () {
        return this.distros.map(distro => {
            return [
                {title: distro.title,
                 content: <EnvoyDistroDistro distro={distro} />}];
        });
    }

    render () {
        return (
            <EnvoyDistroSections
              sections={this.sections} />
        );
    }
}

export default class EnvoyDistroPage extends React.PureComponent {
    static propTypes = exact({});

    render () {
        return (
            <div className="App container-fluid">
              <header className="App-header row">
                <EnvoyDistroSiteHeader />
              </header>
              <main className="App-main row">
                <EnvoyDistroArchitectures />
                <EnvoyDistroDistros />
              </main>
            </div>);
    }
}
