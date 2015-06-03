Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:36831 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888AbbFCENC (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 3 Jun 2015 00:13:02 -0400
Received: by pabqy3 with SMTP id qy3so26615574pab.3
        for <linux-wpan@vger.kernel.org>; Tue, 02 Jun 2015 21:13:02 -0700 (PDT)
Message-ID: <556E7EB5.7010800@gmail.com>
Date: Wed, 03 Jun 2015 09:42:37 +0530
From: Varka Bhadram <varkabhadram@gmail.com>
MIME-Version: 1.0
Subject: Re: [PATCH bluetooth-next] nl802154: export supported commands
References: <1433304558-12628-1-git-send-email-varkab@cdac.in>
In-Reply-To: <1433304558-12628-1-git-send-email-varkab@cdac.in>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: alex.aring@gmail.com, Varka Bhadram <varkab@cdac.in>

On 06/03/2015 09:39 AM, Varka Bhadram wrote:

> This patch will export the supported commands by the devices
> to the user. This is required because user should know supported
> commands by the IEEE-802.15.4 devices. Drivers that are there in
> the mainline are not supporting all the functionalities that the
> core is providing to us.
>
> Signed-off-by: Varka Bhadram <varkab@cdac.in>
> ---
>   include/net/nl802154.h    |    2 ++
>   net/ieee802154/nl802154.c |   33 +++++++++++++++++++++++++++++++++
>   2 files changed, 35 insertions(+)

Accidentally send this patch. Its not updated. Sorry for the noise.

I will send the updated one.

-- 
Varka Bhadram

