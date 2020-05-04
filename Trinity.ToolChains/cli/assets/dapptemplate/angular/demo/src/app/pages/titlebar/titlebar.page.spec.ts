import { CUSTOM_ELEMENTS_SCHEMA } from '@angular/core';
import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { TitlebarPage } from './titlebar.page';

describe('TitlebarPage', () => {
  let component: TitlebarPage;
  let fixture: ComponentFixture<TitlebarPage>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ TitlebarPage ],
      schemas: [CUSTOM_ELEMENTS_SCHEMA],
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(TitlebarPage);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
