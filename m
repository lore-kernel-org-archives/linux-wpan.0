Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-io1-f68.google.com ([209.85.166.68]:34564 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfEHPnb (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 8 May 2019 11:43:31 -0400
Received: by mail-io1-f68.google.com with SMTP id g84so9485035ioa.1
        for <linux-wpan@vger.kernel.org>; Wed, 08 May 2019 08:43:30 -0700 (PDT)
Date: Wed, 8 May 2019 11:43:21 -0400
From: Alexander Aring <aring@mojatatu.com>
Subject: Re: wpan-ping not working for an initial setup of Openlabs 802.15.4
 modules connected to rapsberry pi.
Message-ID: <20190508154321.34euz2ygus2qjbvv@x220t>
References: <C17AA022-0F79-4663-877F-A4A0A62E141A@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <C17AA022-0F79-4663-877F-A4A0A62E141A@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Aditya Nath <nath46950@gmail.com>
Cc: linux-wpan@vger.kernel.org

Hi,

On Fri, Apr 26, 2019 at 12:29:54AM -0400, Aditya Nath wrote:
> Hi,
> 
> Sorry for creating another thread of mails, but I couldn’t figure out how to properly send the mail in the same chain using git-send-mail.
> 

latest rpi kernel is known to have problems which I don't have with a
mainline kernel.

try:

sudo rpi-update 936a8dc3a605c20058fbb23672d6b47bca77b0d5

which downgrades the kernel to a version where I heard from people that
it works with the rpi kernel.

- Alex
