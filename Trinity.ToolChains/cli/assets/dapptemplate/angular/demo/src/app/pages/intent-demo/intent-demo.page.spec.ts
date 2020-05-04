import { CUSTOM_ELEMENTS_SCHEMA } from '@angular/core';
import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { IntentDemoPage } from './intent-demo.page';

describe('IntentDemoPage', () => {
  let component: IntentDemoPage;
  let fixture: ComponentFixture<IntentDemoPage>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ IntentDemoPage ],
      schemas: [CUSTOM_ELEMENTS_SCHEMA],
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(IntentDemoPage);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
