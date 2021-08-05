
import React from 'react';

import {Provider} from 'react-redux';

import 'bootstrap/dist/css/bootstrap.min.css';
import './css/playground-site.css';

import {EnvoyDistroPage} from '../layout';
import {EnvoyDistroSiteContext} from "./context";
import EnvoyDistroSite from './site';

import store from "./store";


export default class EnvoyDistroSiteApp extends React.PureComponent {

    state = {site: null}

    async componentDidMount () {
        const site = new EnvoyDistroSite(store);
        await site.load();
        this.setState({site});
    }

    render () {
        const {site} = this.state;
        if (!site) {
            return '';
        }
        return (
            <Provider store={store}>
              <EnvoyDistroSiteContext.Provider value={site}>
                <EnvoyDistroPage />
              </EnvoyDistroSiteContext.Provider>
            </Provider>
        );
    }
}
