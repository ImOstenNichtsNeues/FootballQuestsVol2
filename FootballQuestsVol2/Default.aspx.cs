using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Label1.Visible = false;
        if(!Page.IsPostBack)
        Timer1.Enabled = false;
    }

    protected void WCButton_Click(object sender, EventArgs e)
    {
        //Label1.Text = "debilstrasburger";
        blockButtons();
        QuestionsSDS.Update();
        QuestionsSDS.SelectParameters[1].DefaultValue = "WC";
        QuestionsSDS.SelectParameters[0].DefaultValue = "1";
        QuestionsSDS.DataBind();
    }
    protected void EUROButton_Click(object sender, EventArgs e)
    {
        //yo
        blockButtons();
        QuestionsSDS.Update();
        QuestionsSDS.SelectParameters[1].DefaultValue = "EURO";
        QuestionsSDS.SelectParameters[0].DefaultValue = "1";
        QuestionsSDS.DataBind();
    }
    public void blockButtons()
    {
        WCButton.Enabled = false; EUROButton.Enabled = false; CLButton.Enabled = false; PLButton.Enabled = false;
        TimerLabel.Text = "5";
        Timer1.Enabled = true;
    }

    protected void QuestionsSDS_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {

    }

    protected void QuestionsRepeater_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        if(e.CommandName == "setTrue")
        {
            if (Convert.ToBoolean(e.CommandArgument))
            {
                Label1.Text += "1";
            }
            else
            {
                Label1.Text += "0";
            }
        }
        else if(e.CommandName == "setFalse")
        {
            if (!Convert.ToBoolean(e.CommandArgument))
            {
                Label1.Text += "1";
            }
            else
            {
                Label1.Text += "0";
            }
        }
        int number = Convert.ToInt32(NumberOfQuestsHF.Value) + 1;
        NumberOfQuestsHF.Value = number.ToString();
        QuestionsSDS.DataBind();
        CountScore();
    }
    public void CountScore()
    {
        if (Label1.Text.Length == 14 || TimerLabel.Text =="0")
        {
            Timer1.Enabled = false;
            int score = 0;
            for(int i=0; i<Label1.Text.Length; i++)
            {
                score = Label1.Text[i] == '1' ? score + 1 : score;
            }
            Label1.Text = score.ToString() + "/14.                  ";
            //foreach(RepeaterItem item in QuestionsRepeater.Items)
            //{
            //    Button TB = item.FindControl("TrueButton") as Button;
            //    Button FB = item.FindControl("FalseButton") as Button;
            //    TB.Enabled = false; FB.Enabled = false;
            //}  
                CHECKtb.Text = QuestionsRepeater.Items.Count.ToString();
            CHECKtb.Visible = false; Label1.Visible = true;
        }
    }


    protected void QuestionsRepeater_PreRender(object sender, EventArgs e)
    {       
            foreach (RepeaterItem item in QuestionsRepeater.Items)
            {
                Button trueButton = item.FindControl("TrueButton") as Button;
                Button falseButton = item.FindControl("FalseButton") as Button;
                if(item.ItemIndex < QuestionsRepeater.Items.Count - 1)
            {
                trueButton.Enabled = false; falseButton.Enabled = false;
            }      
                if((QuestionsRepeater.Items.Count == 14 && Label1.Text.Length > 14) || TimerLabel.Text == "0") 
            {
                trueButton.Enabled = false; falseButton.Enabled = false;
            }
        }
        
    }

    protected void Timer1_Tick(object sender, EventArgs e)
    {
        int seconds;
        if (Convert.ToString(TimerLabel.Text) != "")
        {
            TimerLabel.Visible = true;
            seconds = int.Parse(TimerLabel.Text);
            if (seconds > 0)
            {
                TimerLabel.Text = (seconds - 1).ToString();
            }
            else
            {
                Timer1.Enabled = false;
                foreach (RepeaterItem item in QuestionsRepeater.Items)
                {
                    //Button TB = item.FindControl("TrueButton") as Button;
                    //Button FB = item.FindControl("FalseButton") as Button;
                    //TB.Enabled = false; FB.Enabled = false;
                }
                CountScore();
            }
        }
    }
}