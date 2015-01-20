Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:37488 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753800AbbATLFn (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 20 Jan 2015 06:05:43 -0500
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout1.w1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0NIH00ABO30CY550@mailout1.w1.samsung.com> for
 linux-wpan@vger.kernel.org; Tue, 20 Jan 2015 11:09:48 +0000 (GMT)
From: Stefan Schmidt <s.schmidt@samsung.com>
References: <1421750140-24760-1-git-send-email-alex.aring@gmail.com>
In-reply-to: <1421750140-24760-1-git-send-email-alex.aring@gmail.com>
Subject: Re: [PATCH wpan-tools 1/2] treewide: shorten commands
Date: Tue, 20 Jan 2015 11:05:26 +0000
Message-id: <006b01d034a0$ff2e9900$fd8bcb00$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=us-ascii
Content-transfer-encoding: 7bit
Content-language: en-gb
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: 'Alexander Aring' <alex.aring@gmail.com>, linux-wpan@vger.kernel.org

Hello.

On 20/01/15 11:35, Alexander Aring wrote:
> This patch shorten all commands. I had the idea to make a similarity
> from PIB/MIB values according the 802.15.4 names convention but this is
> bad for fast shell hacking. Mainly I remove the underscore and some
> additional information which are not necessary like "_addr" in
> "short_addr" and "extended_addr" and such things.
>
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
>   src/info.c      | 10 +++++-----
>   src/interface.c | 20 ++++++++++----------
>   src/mac.c       | 10 +++++-----
>   src/phy.c       |  6 +++---
>   4 files changed, 23 insertions(+), 23 deletions(-)

Hmm, it feels like you are going overboard with shorting things here. 
Why is the reason behind it? Just less typing? Shell auto completion 
would handle this. :)

I mean it is up to you but with this you might break scripts that are 
already out there and I think the current  commands are quite fine. 
Cutting out the underscores makes some of these hard to read imho.

regards
Stefan Schmidt


