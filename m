Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-it0-f48.google.com ([209.85.214.48]:33881 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752435AbeAXTcz (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 24 Jan 2018 14:32:55 -0500
Received: by mail-it0-f48.google.com with SMTP id m11so19317775iti.1
        for <linux-wpan@vger.kernel.org>; Wed, 24 Jan 2018 11:32:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180124172910.GA5472@picapica.im>
References: <20180124172910.GA5472@picapica.im>
From: Alexander Aring <alex.aring@gmail.com>
Date: Wed, 24 Jan 2018 14:32:53 -0500
Message-ID: <CAB_54W5wE1RXT-AQ=c1QbCXhtLtEmwtQYLDEZpZG6S0Mt0Q5dA@mail.gmail.com>
Subject: Re: Is at86rf230 a SoftMAC device driver?
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: anton@picapica.im
Cc: linux-wpan - ML <linux-wpan@vger.kernel.org>

Hi,

2018-01-24 12:29 GMT-05:00  <anton@picapica.im>:
> Or HardMac one?

we don't support any HardMAC driver, the caFOO (don't remember) is
some HardMAC transceiver which use SoftMAC layer... I already
complained about that... anyway seems too much work for them to
program more HardMAC layer, we just accept it... but it's broken in
some cases (raw frame sendings) and we don't care when we add more
frametypes in SoftMAC handling.

- Alex
