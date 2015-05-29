Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:36559 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754278AbbE2JDe (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 29 May 2015 05:03:34 -0400
Received: by pacux9 with SMTP id ux9so9107112pac.3
        for <linux-wpan@vger.kernel.org>; Fri, 29 May 2015 02:03:33 -0700 (PDT)
Message-ID: <55682B4D.4030906@gmail.com>
Date: Fri, 29 May 2015 14:33:09 +0530
From: Varka Bhadram <varkabhadram@gmail.com>
MIME-Version: 1.0
Subject: Re: [PATCHv2 bluetooth-next 0/4] Atusb driver improvements
References: <1432889488-28420-1-git-send-email-stefan@osg.samsung.com>
In-Reply-To: <1432889488-28420-1-git-send-email-stefan@osg.samsung.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>, linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

On 05/29/2015 02:21 PM, Stefan Schmidt wrote:

> Hello.
>
> Some patches to let the atusb driver catchup a bit with newer stack features.
> Namely we now support tx power and promiscuous mode setting. The first patch
> adds some infrastructure for this by adding a function to write parts of a
> register.
>
> The last patch adds me as the maintainer for the driver. Alex suggested that
> I should do this and as I have the device, working on the firmware as well
> and are motivated to enhance it I think its a good idea.
>
> Changes in v2:
> 	Fix checkpatch complains pointed out by Varka Bhadram
>
> Stefan Schmidt (4):
>    ieee802154/atusb: Add function for partial register writes
>    ieee802154/atusb: Add .set_txpower operation to the driver
>    ieee802154/atusb: Add .set_promiscuous_mode driver operation
>    MAINTAINERS: Add myself as maintainer for the atusb driver
>
>   MAINTAINERS                    |   8 ++++
>   drivers/net/ieee802154/atusb.c | 101 +++++++++++++++++++++++++++++++++--------
>   2 files changed, 90 insertions(+), 19 deletions(-)
>
> regards
> Stefan Schmidt
>
Reviewed-by: Varka Bhadram <varkabhadram@gmail.com>

-- 
Varka Bhadram

