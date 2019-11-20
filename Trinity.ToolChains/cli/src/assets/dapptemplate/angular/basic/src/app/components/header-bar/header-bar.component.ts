import { Component, OnInit, Input } from '@angular/core';
import { AppManager } from '@elastosfoundation/trinity-types';

declare let appService: any;

@Component({
    selector: 'header-bar',
    templateUrl: './header-bar.component.html',
    styleUrls: ['./header-bar.component.scss'],
})
export class HeaderBarComponent implements OnInit {
    @Input('title') title: string = "";
    @Input('showMinimize') showMinimize: boolean;
    @Input('showClose') showClose: boolean;

    constructor() { }

    ngOnInit() { }

    minimize() {
        AppManager.launcher();
    }

    close() {
        AppManager.close();
    }
}
