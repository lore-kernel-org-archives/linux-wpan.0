Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:35483 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755523AbbCRL7y (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 18 Mar 2015 07:59:54 -0400
Received: by pdbop1 with SMTP id op1so41226943pdb.2
        for <linux-wpan@vger.kernel.org>; Wed, 18 Mar 2015 04:59:54 -0700 (PDT)
Message-ID: <550968A4.5050908@gmail.com>
Date: Wed, 18 Mar 2015 17:29:32 +0530
From: Varka Bhadram <varkabhadram@gmail.com>
MIME-Version: 1.0
Subject: Re: [PATCH bluetooth-next 0/2] nl802154: implement new SET commands
References: <1426678822-26644-1-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1426678822-26644-1-git-send-email-alex.aring@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, mkl@pengutronix.de

Hi Alex,

On 03/18/2015 05:10 PM, Alexander Aring wrote:

> Hi,
>
> this patch-series implement the already existed SET commands of an interface
> and a wpan-phy. Currently we have one CMD for each setting which was a mistake
> by me to implement it in this way. So we aren't currently a "real" UAPI header
> for nl802154 and it's still under development. I decide now to change to
> implement these setting in this way now. Currently I let these commands in
> coexistens with the old commands but _NOTE_ I will remove the other commands
> from the nl802154 later.
>
> So please use the new commands. When these patches are mainline I also want to
> release a new wpan-tools release which use this new interface. Then everybody
> has some time to change to the new wpan-tools release. After this "time" I will

Its better to send the patches along with wpan-tools, so that we can do the testing..

> remove the obsolete nl802154 commands from the header. This means older
> wpan-tools releases doesn't work any more with new kernels. Also this means
> newer wpan-tools releases doesn't work with older kernels. That will end in
> some kind of chaos and I will note this on the website.
>
> This beahviour to do it in only one command is much easier to handle in
> userspace, like clicking an "apply button".
>
> - Alex
>
> Alexander Aring (2):
>    nl802154: add set wpan phy cmd
>    nl802154: add set interface cmd
>
>   net/ieee802154/nl802154.c | 162 ++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 162 insertions(+)
>
-- 
Varka Bhadram

