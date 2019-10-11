import React from 'react'
import styled from 'styled-components'
import DOMPurify from 'dompurify'
import markdownIt from 'markdown-it'
import markdownItMermaid from '@liradb2000/markdown-it-mermaid'
import taskLists from 'markdown-it-task-lists'
import sub from 'markdown-it-sub'
import sup from 'markdown-it-sup'
import footnote from 'markdown-it-footnote'
import abbr from 'markdown-it-abbr'
import emoji from 'markdown-it-emoji'

const mdi = markdownIt({
  linkify: true, // Autoconvert URL-like text to links
  typographer: true // Enable some language-neutral replacement + quotes beautification
})
  .use(markdownItMermaid)
  .use(taskLists)
  .use(footnote)
  .use(sub)
  .use(sup)
  .use(abbr)
  .use(emoji)

function MarkedPreview({ content }) {
  return (
    <Wrapper
      dangerouslySetInnerHTML={{
        __html: DOMPurify.sanitize(mdi.render(content))
      }}
    />
  )
}

export default MarkedPreview

const Wrapper = styled.div``
