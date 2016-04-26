Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:42844 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752188AbcDZHjZ (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Tue, 26 Apr 2016 03:39:25 -0400
Message-ID: <1461656345.16188.6.camel@sipsolutions.net>
Subject: Re: [PATCH net-next 9/9] wireless: use nla_put_u64_64bit()
From: Johannes Berg <johannes@sipsolutions.net>
Date: Tue, 26 Apr 2016 09:39:05 +0200
In-Reply-To: <1461572722-6029-10-git-send-email-nicolas.dichtel@6wind.com>
References: <1461572722-6029-1-git-send-email-nicolas.dichtel@6wind.com>
	 <1461572722-6029-10-git-send-email-nicolas.dichtel@6wind.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, jhs@mojatatu.com, stephen@networkplumber.org, pshelar@nicira.com, aar@pengutronix.de, linux-wpan@vger.kernel.org, wensong@linux-vs.org, horms@verge.net.au, ja@ssi.bg, pablo@netfilter.org, kaber@trash.net, kadlec@blackhole.kfki.hu, lvs-devel@vger.kernel.org, netfilter-devel@vger.kernel.org, linux-wireless@vger.kernel.org

Hi Nicholas,

Thanks for doing this.

I'll also add a fix for the macro-generated nla_put_64() in
nl80211_send_station(), unless there was a particular reason you didn't
take that one?

I suspect you just missed it while grepping, but wanted to ask.

johannes
