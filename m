Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:52617 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1945985AbbEVKbB (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Fri, 22 May 2015 06:31:01 -0400
Message-ID: <555F0560.8060805@osg.samsung.com>
Date: Fri, 22 May 2015 12:30:56 +0200
From: Stefan Schmidt <stefan@osg.samsung.com>
MIME-Version: 1.0
Subject: Re: [PATCH bluetooth-next 4/4] mac802154: use atomic ops for sequence
 incrementation
References: <1432285031-3360-1-git-send-email-alex.aring@gmail.com> <1432285031-3360-5-git-send-email-alex.aring@gmail.com> <555EEFF1.90603@pengutronix.de>
In-Reply-To: <555EEFF1.90603@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de

Hello.

On 22/05/15 10:59, Marc Kleine-Budde wrote:
> On 05/22/2015 10:57 AM, Alexander Aring wrote:
>> This patch will use atomic operations for sequence number incrementation
>> while MAC header generation. Upper layers like af_802154 or 6LoWPAN
>> could call this function in a parallel context while generating 802.15.4
>> MAC header before queuing into wpan interfaces transmit queue.
> what about swapping patch 3 and 4?

To avoid having problems during a git bisect later one? E.g. having the 
lock removed but no atomic in place?

regards
Stefan Schmidt

