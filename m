Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:47513 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752841AbaJFOaO (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 6 Oct 2014 10:30:14 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by gateway2.nyi.internal (Postfix) with ESMTP id DA151207BE
	for <linux-wpan@vger.kernel.org>; Mon,  6 Oct 2014 10:30:13 -0400 (EDT)
Message-ID: <5432A776.9000103@signal11.us>
Date: Mon, 06 Oct 2014 10:30:14 -0400
From: Alan Ott <alan@signal11.us>
MIME-Version: 1.0
Subject: Re: [PATCH linux-wpan v4] ieee802154: mrf24j40: Add support for MRF24J40MC
References: <1412588385-30388-1-git-send-email-simon.vincent@xsilon.com>
In-Reply-To: <1412588385-30388-1-git-send-email-simon.vincent@xsilon.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Simon Vincent <simon.vincent@xsilon.com>, linux-wpan@vger.kernel.org
Cc: alex.aring@gmail.com

On 10/06/2014 05:39 AM, Simon Vincent wrote:
> The MRF24J40MC module has an external amplifier which should be
> enabled. The TX power has to be lowered to meet FCC regs.
>
> Signed-off-by: Simon Vincent <simon.vincent@xsilon.com>
> ---
> v3 -> v4:
> * Fix mistake where was doing a write instead of a spi read.
>

Acked-by: Alan Ott <alan@signal11.us>

