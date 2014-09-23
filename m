Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:35880 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752624AbaIWCqy (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Mon, 22 Sep 2014 22:46:54 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by gateway2.nyi.internal (Postfix) with ESMTP id 3D58C206C8
	for <linux-wpan@vger.kernel.org>; Mon, 22 Sep 2014 22:46:54 -0400 (EDT)
Message-ID: <5420DF1B.1000302@signal11.us>
Date: Mon, 22 Sep 2014 22:46:51 -0400
From: Alan Ott <alan@signal11.us>
MIME-Version: 1.0
Subject: Re: [PATCH wpan-next v3 0/3] cleanup for mrf24j40
References: <1411124237-16919-1-git-send-email-varkab@cdac.in>
In-Reply-To: <1411124237-16919-1-git-send-email-varkab@cdac.in>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>, linux-wpan@vger.kernel.org
Cc: Varka Bhadram <varkab@cdac.in>

On 09/19/2014 06:57 AM, Varka Bhadram wrote:
> changes since v2:
> - generated patches based on wpan-next
>
> changes since v1:
> - changes in commit messages and descriptions suggested by Alan Ott
>
> Varka Bhadram (3):
>    mrf24j40: fix Missing a blank line after declarations
>    mrf24j40: remove unnecessary return statement
>    mrf24j40: use pr_* / dev_* instead of printk()
>
>   drivers/net/ieee802154/mrf24j40.c |   19 ++++++++++---------
>   1 file changed, 10 insertions(+), 9 deletions(-)
>

Acked-by: Alan Ott <alan@signal11.us>

Thanks.

