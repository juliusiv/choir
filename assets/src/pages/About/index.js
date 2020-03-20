import React from "react";
import css from "<style>"
import Link from "<choir>/components/Link";
import PageContainer, { Pages } from "<choir>/containers/PageContainer";

const QAndA = ({ question, answer, ...props }) => {
  return (
    <div {...props} className={css`mb2`}>
      <h3 className={css`cRed bold`}>{question}</h3>
      <p>{answer}</p>
    </div>
  );
};

const QUESTIONS_AND_ANSWERS = [
  {
    question: "What is Choir?",
    answer: "It's a generative music website. Generative music is constantly evolving and is automagically created in a system. Essentially, we give the system some inputs, those inputs map to various aspects of the music (like tempo or pitch, for example, but Choir's a bit more intricate than that), and then the music changes accordingly. The inputs that Choir uses are attributes of the people that are listening at any given time — things like geographical location, total number of listeners, weather where people are listening, etc. So we're even changing the inputs to Choir's system all the time, whenever people join or leave.",
    id: "wat",
  },
  {
    question: "What kind of music is it?",
    answer: "We'll start with just ambient music. Once we work out the kinks and learn some things, we may try some other styles of music.",
    id: "genre",
  },
  {
    question: "When would I listen to this?",
    answer: "Choir should be great to listen to while working on your computer.",
    id: "why",
  },
  {
    question: "What's happening to my data?",
    answer: "In order to generate music, Choir tries to figure out locational things about each user when they connect. It basically boils down to approximately where the user is (like within what city) and what it's like there at that time. We take this data and aggregate it, to approximate things like how many of the current users are in Asia. When you leave the site, all of this data gets erased. Other than this stuff, we store basic things about your profile, like name (to personalize things a bit), email (in case we need to notify you), and payment info. Those things are stored in Choir and we don't give it out to anyone. There are no Google/Ad/whatever trackers on the Choir site.",
    id: "data",
  },
  {
    question: "What's pricing like?",
    answer: "There aren't exact numbers yet, but Choir is going to try out a variable payment model. That means, billing will be monthly, and the price will be determined by how many people are signed up for Choir at that time; so each month the price could change slightly. That said, the monthly price will never be more than $5, and we hope it only costs about $15 per year.",
    id: "pricing",
  }
]

class About extends React.Component {
  render() {
    return (
      <PageContainer page={Pages.ABOUT}>
        <h1>Choir</h1>

        <h2 className={css`mb1`}>Questions and Answers</h2>

        <div className={css`mb3`}>
          <ul className={css`bulletsNone`}>
            {
              QUESTIONS_AND_ANSWERS.map(({ question, id }) => (
                <li key={id}>
                  <Link to={`/about#${id}`}>{question}</Link>
                </li>
              ))
            }
          </ul>
        </div>

        {
          QUESTIONS_AND_ANSWERS.map(props => (
            <QAndA {...props} key={props.id} />
          ))
        }
      </PageContainer>
    );
  }
}

export default About;
