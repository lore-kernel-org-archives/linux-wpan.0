Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:38024 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751447AbcB2Sqi (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Mon, 29 Feb 2016 13:46:38 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id C9AFC2096B
	for <linux-wpan@vger.kernel.org>; Mon, 29 Feb 2016 13:46:37 -0500 (EST)
Subject: Re: [PATCH] mrf24j40: fix security-enabled processing on inbound
 frames
References: <56C60EBA.2070707@zopieux.com> <56CC265C.2040906@pengutronix.de>
From: Alan Ott <alan@signal11.us>
Message-ID: <56D4920D.7050306@signal11.us>
Date: Mon, 29 Feb 2016 13:46:37 -0500
MIME-Version: 1.0
In-Reply-To: <56CC265C.2040906@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aar@pengutronix.de>
Cc: linux-wpan@vger.kernel.org, netdev@vger.kernel.org, Alexander Aring <alex.aring@gmail.com>, zopieux <web@zopieux.com>

On 02/23/2016 04:29 AM, Alexander Aring wrote:
> Alan, do you have some comments about that?
>
> Currently the mrf24j40 goes into a deadlock if a frame with security
> enable bit is set. As you see, I helped myself to create this patch and solve
> this stupid default behaviour of mrf24j40. :-)
>

Hi Alex, I'll look at this today.

Alan.

