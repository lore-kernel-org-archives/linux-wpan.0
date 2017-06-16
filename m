Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wr0-f177.google.com ([209.85.128.177]:35225 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750921AbdFPQgo (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 16 Jun 2017 12:36:44 -0400
Received: by mail-wr0-f177.google.com with SMTP id y25so2130242wrd.2
        for <linux-wpan@vger.kernel.org>; Fri, 16 Jun 2017 09:36:43 -0700 (PDT)
Date: Fri, 16 Jun 2017 18:36:37 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: ieee802154: bad frame received (type = 0)
Message-ID: <20170616163636.5lsfxw5txwou7ejr@omega>
References: <CAAK7Ti--Z6rpE8rfUcCRADc8YJ8pWcw65dsOZnm3bx+rofWirw@mail.gmail.com>
 <20170616132416.zx2akoo2othdflke@omega>
 <CAAK7Ti_Na=7B+aewRzoXrOHO8FfoJX1LRJAZtLY10zQRCmXdPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAK7Ti_Na=7B+aewRzoXrOHO8FfoJX1LRJAZtLY10zQRCmXdPg@mail.gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: JANARDHANACHARI KELLA <eni.chari@gmail.com>
Cc: linux-wpan@vger.kernel.org

Hi,

On Fri, Jun 16, 2017 at 08:49:00PM +0530, JANARDHANACHARI KELLA wrote:
> Thank you Alex, for your support.
> 
> I will follow your guidance. As mentioned in your replay mail.

ok. It could also be possible somebody sends frames with frame type 0
which is beacon frames... so if there is some other device which could
send it and you receive them: this error will shown because we support
dataframes only right now. No MLME-ops or others...

It sounds like the issue which I described because the spi controller
will moslty read zeros at some part of frame payload...

You could also check wireshark if the payload looks like garbage.

- Alex
