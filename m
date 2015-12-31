Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:33553 "EHLO
	mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753552AbbLaPHk (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 31 Dec 2015 10:07:40 -0500
Received: by mail-pf0-f172.google.com with SMTP id q63so121214484pfb.0
        for <linux-wpan@vger.kernel.org>; Thu, 31 Dec 2015 07:07:40 -0800 (PST)
Subject: Re: [PATCH v3 1/1] ieee802154: cc2520: Check CRC & add promiscuous
References: <1450923581-967-1-git-send-email-bradjc5@gmail.com>
 <1450923581-967-2-git-send-email-bradjc5@gmail.com>
From: Varka Bhadram <varkabhadram@gmail.com>
Message-ID: <568544B7.3010903@gmail.com>
Date: Thu, 31 Dec 2015 20:37:35 +0530
MIME-Version: 1.0
In-Reply-To: <1450923581-967-2-git-send-email-bradjc5@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Brad Campbell <bradjc5@gmail.com>, Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org

Hi Brad Campbell,

On 12/24/2015 7:49 AM, Brad Campbell wrote:

> This patch adds checking the "CRC_OK" bit at the end of packets coming
> from the CC2520 radio. It also adds support for putting the radio in
> promiscuous mode (in which packets are not dropped if the CRC fails).
> In promiscuous mode the AUTOCRC flag is cleared so that the driver can
> pass the received CRC to the monitors.
>
> The radio now defaults to frame filtering (checking that the destination
> and PANID in the incoming packet matches the local node). This matches
> the other 15.4 radios and is what a user would expect to be the default.
>
> Other changes:
>
> 1. Adds LQI calculation
> 2. Makes #defines for relevant bit fields in CC2520 registers
>
> Signed-off-by: Brad Campbell <bradjc5@gmail.com>
> ---
>   drivers/net/ieee802154/cc2520.c | 145 +++++++++++++++++++++++++++++++++-------
>   1 file changed, 122 insertions(+), 23 deletions(-)
>
Looks good to me.

Acked-by: Varka Bhadram <varkabhadram@gmail.com>

