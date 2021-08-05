
import React from 'react';
import exact from 'prop-types-exact';

import EnvoyInverseLogo from '../app/images/logo-inverse.svg';
import GithubLogo from '../app/images/github.svg';
import LinkIcon from '../app/images/link.svg';
import ServiceIcon from '../app/images/service.png';

import EnvoyDistroSiteWelcome from './welcome';
import {EnvoyDistroSiteSections} from './section';

export class EnvoyDistroSwitch extends React.PureComponent {

    render () {
        return <div>foo</div>;
    }

}

export class EnvoyDistroSiteHome extends React.PureComponent {
    static propTypes = exact({});

    get sections () {
        return [
            [{title: 'EnvoyDistro',
              icon: EnvoyInverseLogo,
              content: <EnvoyDistroSiteWelcome />}],
        ];
    }

    render () {
        return (
            <>
              <EnvoyDistroSwitch />
              <EnvoyDistroSiteSections
                sections={this.sections} />
            </>
        );
    }
}
