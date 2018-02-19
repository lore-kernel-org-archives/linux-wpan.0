Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pg0-f46.google.com ([74.125.83.46]:35734 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753624AbeBSVm7 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 19 Feb 2018 16:42:59 -0500
Received: by mail-pg0-f46.google.com with SMTP id l131so6356052pga.2
        for <linux-wpan@vger.kernel.org>; Mon, 19 Feb 2018 13:42:58 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <23732.1519061365@obiwan.sandelman.ca>
References: <1519037471-17668-1-git-send-email-liuxuenetmail@gmail.com>
 <1519037471-17668-4-git-send-email-liuxuenetmail@gmail.com> <23732.1519061365@obiwan.sandelman.ca>
From: Xue Liu <liuxuenetmail@gmail.com>
Date: Mon, 19 Feb 2018 22:42:57 +0100
Message-ID: <CAJuUDwsVZiRhLyD6T9uWzyyfjayDjEJCrTWF-Xet6qG=B_UTzQ@mail.gmail.com>
Subject: Re: [PATCHv2 3/3] ieee802154: Add MCR20A IEEE 802.15.4 device driver
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Michael Richardson <mcr@sandelman.ca>
Cc: linux-wpan@vger.kernel.org

Hello,


On 19 February 2018 at 18:29, Michael Richardson <mcr@sandelman.ca> wrote:
> Xue Liu <liuxuenetmail@gmail.com> wrote:
>     > This driver implements a subset of ieee802154_ops. It has no support
>     > for CSMA due to lack of hardware support. It has currently no support
>     > for its proprietary feature: Dual PAN.
>
> I think you mean, that the driver has no support for the MCR20A Dual
> Pan feature, because the 802.15.4 layer has no way to deal with it.
>
Correct. We have a discussion before.
> A suggestion is to create two virtual devices!
>
OK. I will try to add it in the second release.
> Does the MCR20A support any of the TSCH features?
>
>
I believe there is no TSCH feartures in the hardware.
> --
> ]               Never tell me the odds!                 | ipv6 mesh networks [
> ]   Michael Richardson, Sandelman Software Works        | network architect  [
> ]     mcr@sandelman.ca  http://www.sandelman.ca/        |   ruby on rails    [
>
