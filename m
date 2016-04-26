Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:37717 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752235AbcDZHvq (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 26 Apr 2016 03:51:46 -0400
Received: by mail-wm0-f46.google.com with SMTP id n3so21082918wmn.0
        for <linux-wpan@vger.kernel.org>; Tue, 26 Apr 2016 00:51:45 -0700 (PDT)
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next 9/9] wireless: use nla_put_u64_64bit()
References: <1461572722-6029-1-git-send-email-nicolas.dichtel@6wind.com>
 <1461572722-6029-10-git-send-email-nicolas.dichtel@6wind.com>
 <1461656345.16188.6.camel@sipsolutions.net>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Message-ID: <571F1E03.90703@6wind.com>
Date: Tue, 26 Apr 2016 09:51:31 +0200
MIME-Version: 1.0
In-Reply-To: <1461656345.16188.6.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>, netdev@vger.kernel.org
Cc: davem@davemloft.net, jhs@mojatatu.com, stephen@networkplumber.org, pshelar@nicira.com, aar@pengutronix.de, linux-wpan@vger.kernel.org, wensong@linux-vs.org, horms@verge.net.au, ja@ssi.bg, pablo@netfilter.org, kaber@trash.net, kadlec@blackhole.kfki.hu, lvs-devel@vger.kernel.org, netfilter-devel@vger.kernel.org, linux-wireless@vger.kernel.org

Hi Johannes,

Le 26/04/2016 09:39, Johannes Berg a écrit :
> Hi Nicholas,
> 
> Thanks for doing this.
> 
> I'll also add a fix for the macro-generated nla_put_64() in
> nl80211_send_station(), unless there was a particular reason you didn't
> take that one?
> 
> I suspect you just missed it while grepping, but wanted to ask.
Yes you're right. I missed it. Thank you for the check.

I will send the last patchset in some minutes.


Regards,
Nicolas
