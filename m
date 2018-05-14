Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:38046 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932205AbeENO3t (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 14 May 2018 10:29:49 -0400
Received: by mail-it0-f68.google.com with SMTP id q4-v6so11251217ite.3
        for <linux-wpan@vger.kernel.org>; Mon, 14 May 2018 07:29:48 -0700 (PDT)
Date: Mon, 14 May 2018 10:29:38 -0400
From: Alexander Aring <aring@mojatatu.com>
Subject: Re: [RFC PATCH wpan-next 1/2] ieee802154: hwsim: add replacement for
 fakelb
Message-ID: <20180514142938.afncswlenblaea7a@x220t>
References: <20180427212154.29582-1-aring@mojatatu.com>
 <20180427212154.29582-2-aring@mojatatu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180427212154.29582-2-aring@mojatatu.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: stefan@osg.samsung.com
Cc: linux-wpan@vger.kernel.org, kernel@mojatatu.com

Hi,

On Fri, Apr 27, 2018 at 05:21:53PM -0400, Alexander Aring wrote:
> This patch adds a new virtual driver mac802154_hwsim which is based on
> the fakelb driver.
> The fakelb driver will get deprecated and hopefully removed someday.
> The main reason for doing this step is to rename the driver to
> mac802154_hwsim to have a similar naming scheme as mac80211_hwsim,
> which is more popular in the 802.11 wireless word and the idea is the
> same behind this driver.
> 
> The new features of this driver are to have knowledge about connected
> edges, which can be changed during runtime. This offers a testing
> environment for routing protocols e.g. RPL.
> The default behaviour is still as fakelb: two radios connected to each
> other. New added radios during runtime will not be connected to other
> wpan_hwsim instances.
> 
> The netlink api is not namespace aware on purpose, only the registered
> wpan_phy's can be moved to namespaces. The physical layer according to
> wiresless "air" communication can be handled across namespaces.
> 
> Furthermore the edges can be weighted with the LQI value according IEEE
> 802.15.4 which offers additional handling to mark bad or good connection
> indicators to other connected virtual phys.
> 
> Signed-off-by: Alexander Aring <aring@mojatatu.com>

somebody (don't cc him, I think he don't want to be public) reported
about issues with hwsim privetly. I will check on it and enable more
kernel debugging stuff in kernel hacking feature to see all
locking/stack issues.

TO ALL: never send me private (and absolutely no HTML mails) to me to
report problems. Please do it here.

Thanks.

I will look for this today and change mostly the suggested changes.

- Alex
