Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:33751 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750707AbaISJlz (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 19 Sep 2014 05:41:55 -0400
Date: Fri, 19 Sep 2014 11:41:48 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH bluetooth-next v2 0/3] cleanup for mrf24j40 driver
Message-ID: <20140919094052.GA19085@omega>
References: <1411101911-12462-1-git-send-email-varkab@cdac.in>
 <20140919090611.GA17051@omega>
 <541BF7F4.4020508@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <541BF7F4.4020508@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org, alan@signal11.us, Varka Bhadram <varkab@cdac.in>

On Fri, Sep 19, 2014 at 03:01:32PM +0530, Varka Bhadram wrote:
> Hi Alex,
> 
> On 09/19/2014 02:36 PM, Alexander Aring wrote:
> >Hi Varka,
> >
> >nice to read you again. :-) I already thought that I was maybe a little
> >bit too harsh to you for explaining changing dev->add_len during runtime
> >will occur in unexcept behaviour. Sorry.
> 
> For dev->addr_len, i think David asked a question.. Isn't it..?
> 

yes, I didn't answer. I decide now to put this issue at the last item of
my todo queue. If you like you can try it. I will answer him that I do
other things right now and this issue is more complex.


Also you did the cc2520 driver, you can add you as maintainer for this
driver. I have such devices here but on contiki nodes.

> We need to find a way to add this. Based on this only RFC6775 is going to
> work.
> 
> But i implemented RFC6775 it works for Extended addresses only. I used the
> system
> witch use extended address.
> 

ok.
> >Nevertheless welcome back. I want to apply it when Alan finally sends a
> >"Acked-by: ...", but why is this tagged with bluetooth-next?
> 
> I am also waiting for Alan "Acked-by:..."  :-)
> 
> >There are other mrf24j40 patches around and it's better to send this in
> >a whole patch series when all patches are on wpan-next/testing. Then I
> >will send these patches to bluetooth-next. When applied I will rebase
> >the wpan-next/master to bluetooth-next/master.
> 
> Ok. I got your point. Thanks... I will respin this series with wpan-next
> tag...
> 
> >Only 6LOWPAN GENERIC patches should be send to bluetooth-next.
> 
> Ok.
> 
> We are having multiple branches on wpan-next tree.
> I want to know which branch is for what,..?
> 

master. Should easy to use git cherry-pick here, it should have the same
implementation for linux-wpan-next (802.15.4 branch only) like
linux-bluetooth-next (802.15.4 branch only).

You know, we already talked about how to decreasing workload of other
maintainers. This will decrease the workload of bluetooth maintainers.

- Alex
