<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="StylesForFootballApp.css" rel="stylesheet" type="text/css" />
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
            <asp:UpdatePanel ID="TimingUP" runat="server"  UpdateMode="Conditional">
                <ContentTemplate>
                    <asp:Label ID="timeStartLabel" runat="server" Text="TIMER [s]:"></asp:Label>
                    <asp:Label ID="TimerLabel" runat="server"></asp:Label>
                    <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                    </asp:UpdateProgress>
                    <br /><asp:Label ID="scoreLabel" runat="server" Text="SCORE:"></asp:Label>
                </ContentTemplate>
               <Triggers>
                   <asp:AsyncPostBackTrigger ControlID="Timer1" EventName="Tick" />
               </Triggers>
            </asp:UpdatePanel>
 <asp:Timer ID="Timer1" runat="server" OnTick="Timer1_Tick" Interval="1000">
                </asp:Timer>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                <ContentTemplate>

                    <asp:Label ID="Label1" runat="server"></asp:Label>
                    <asp:HiddenField ID="NumberOfQuestsHF" runat="server" Value="1" />
                    <asp:Label ID="CHECKtb" runat="server"></asp:Label>
                    <table class="table">
                        <tr id="CategoryTable">
                            <td class="mainCell">Choose category:
                            </td>
                            <td class="mainCell">
                                <asp:Button ID="WCButton" runat="server" Text="World Cup" CssClass="button" OnClick="WCButton_Click" />
                            </td>
                            <td class="mainCell">
                                <asp:Button ID="EUROButton" runat="server" Text="Euro" CssClass="button" OnClick="EUROButton_Click" />
                            </td>
                            <td class="mainCell">
                                <asp:Button ID="PLButton" runat="server" Text="Premier League" CssClass="button" />
                            </td>
                            <td class="mainCell">
                                <asp:Button ID="CLButton" runat="server" Text="Champions League" CssClass="button" />
                            </td>
                        </tr>
                    </table>
                    <asp:Repeater ID="QuestionsRepeater" runat="server" DataSourceID="QuestionsSDS" OnItemCommand="QuestionsRepeater_ItemCommand" OnPreRender="QuestionsRepeater_PreRender">
                        <HeaderTemplate>
                            <table class="table">
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr>
                                <td class="repeaterLeftCell">
                                    <%# Eval("ThesisPhrase") %>
                                </td>
                                <td class="repeaterTRueFalseCell">
                                    <asp:Button ID="TrueButton" runat="server" Text="TRUE" CommandName="setTrue" CommandArgument='<%# Eval("Answer") %>' CssClass="button" />
                                </td>
                                <td class="repeaterTRueFalseCell">
                                    <asp:Button ID="FalseButton" runat="server" Text="FALSE" CommandName="setFalse" CommandArgument='<%# Eval("Answer") %>' CssClass="button" />
                                </td>
                            </tr>
                        </ItemTemplate>
                        <FooterTemplate>
                            </table>
                        </FooterTemplate>
                    </asp:Repeater>
                    <asp:SqlDataSource ID="QuestionsSDS" runat="server" ConnectionString="<%$ ConnectionStrings:SoccerQuestionsConnectionString %>" SelectCommand="SELECT TOP(@top) Id, ThesisCategory, ThesisPhrase, Answer, randomNumber FROM SoccerQuiz WHERE (ThesisCategory = @ThesisCategory) ORDER BY randomNumber ASC" OnSelecting="QuestionsSDS_Selecting" UpdateCommand="UPDATE SoccerQuiz SET randomNumber = CAST(RAND(CHECKSUM(NEWID())) * 1000 AS INT)">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="NumberOfQuestsHF" DbType="Int32" DefaultValue="" Name="top" PropertyName="Value" />
                            <asp:Parameter DefaultValue="" Name="ThesisCategory" Type="String" />
                        </SelectParameters>
                    </asp:SqlDataSource>


                </ContentTemplate>

                   <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="Timer1" EventName="Tick" />
                </Triggers>
            </asp:UpdatePanel>


        </div>

    </form>
</body>
</html>
