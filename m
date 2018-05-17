Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:38526 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751047AbeEQU3k (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 17 May 2018 16:29:40 -0400
Received: by mail-it0-f66.google.com with SMTP id q4-v6so10517245ite.3
        for <linux-wpan@vger.kernel.org>; Thu, 17 May 2018 13:29:40 -0700 (PDT)
Date: Thu, 17 May 2018 16:29:34 -0400
From: Alexander Aring <aring@mojatatu.com>
Subject: Re: [RFC PATCH wpan-next 1/2] ieee802154: hwsim: add replacement for
 fakelb
Message-ID: <20180517202934.azxojzh6hma3arde@x220t>
References: <20180427212154.29582-1-aring@mojatatu.com>
 <20180427212154.29582-2-aring@mojatatu.com>
 <20180514142938.afncswlenblaea7a@x220t>
 <d688a8f2-5414-58ee-74ff-9eccb30abe8d@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d688a8f2-5414-58ee-74ff-9eccb30abe8d@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: linux-wpan@vger.kernel.org, kernel@mojatatu.com

Hi,

On Mon, May 14, 2018 at 05:40:26PM +0200, Stefan Schmidt wrote:
> Hello.
> 
> 
> On 05/14/2018 04:29 PM, Alexander Aring wrote:
> > Hi,
> >
> > On Fri, Apr 27, 2018 at 05:21:53PM -0400, Alexander Aring wrote:
> >> This patch adds a new virtual driver mac802154_hwsim which is based on
> >> the fakelb driver.
> >> The fakelb driver will get deprecated and hopefully removed someday.
> >> The main reason for doing this step is to rename the driver to
> >> mac802154_hwsim to have a similar naming scheme as mac80211_hwsim,
> >> which is more popular in the 802.11 wireless word and the idea is the
> >> same behind this driver.
> >>
> >> The new features of this driver are to have knowledge about connected
> >> edges, which can be changed during runtime. This offers a testing
> >> environment for routing protocols e.g. RPL.
> >> The default behaviour is still as fakelb: two radios connected to each
> >> other. New added radios during runtime will not be connected to other
> >> wpan_hwsim instances.
> >>
> >> The netlink api is not namespace aware on purpose, only the registered
> >> wpan_phy's can be moved to namespaces. The physical layer according to
> >> wiresless "air" communication can be handled across namespaces.
> >>
> >> Furthermore the edges can be weighted with the LQI value according IEEE
> >> 802.15.4 which offers additional handling to mark bad or good connection
> >> indicators to other connected virtual phys.
> >>
> >> Signed-off-by: Alexander Aring <aring@mojatatu.com>
> > somebody (don't cc him, I think he don't want to be public) reported
> > about issues with hwsim privetly. I will check on it and enable more
> > kernel debugging stuff in kernel hacking feature to see all
> > locking/stack issues.
> 
> The positive side is that it got some more testing and you got some problems reported. :-)
> 

My test case is:

while true;do wpan-hwsim edge del 0 1; sleep 1; wpan-hwsim edge add 0 1;sleep 1;done

while I am doing:

ping -f fe80::8e6:9f98:edab:f347%lowpan0 -s 4000

to the other node... -f is imporant.

That should occur some race when there is one... I can't see anything
here. I also enabled a lot of kernel hacking features to check stack
corruption/rcu locking issues. Nothing, it runs over 30 minutes without
problems...

I will ignore that issue, I don't know maybe he added some code on his
own...

- Alex
