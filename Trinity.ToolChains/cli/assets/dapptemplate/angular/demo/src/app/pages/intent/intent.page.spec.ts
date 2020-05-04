import { CUSTOM_ELEMENTS_SCHEMA } from '@angular/core';
import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { IntentPage } from './intent.page';

describe('IntentPage', () => {
  let component: IntentPage;
  let fixture: ComponentFixture<IntentPage>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ IntentPage ],
      schemas: [CUSTOM_ELEMENTS_SCHEMA],
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(IntentPage);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
