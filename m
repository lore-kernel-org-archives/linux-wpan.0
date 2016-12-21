Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lf0-f48.google.com ([209.85.215.48]:33392 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754105AbcLUMbG (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 21 Dec 2016 07:31:06 -0500
Received: by mail-lf0-f48.google.com with SMTP id c13so96834337lfg.0
        for <linux-wpan@vger.kernel.org>; Wed, 21 Dec 2016 04:31:05 -0800 (PST)
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: Re: at86rf230: Allow slow GPIO pins for "rstn"
Date: Wed, 21 Dec 2016 15:30:52 +0300
Message-Id: <1482323452-10642-1-git-send-email-nikita.yoush@cogentembedded.com>
In-Reply-To: <1482103533-13187-1-git-send-email-andrew.smirnov@gmail.com>
References: <1482103533-13187-1-git-send-email-andrew.smirnov@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, Alexander Aring <aar@pengutronix.de>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Chris Healy <cphealy@gmail.com>, Nikita Yushchenko <nikita.yoush@cogentembedded.com>

> Driver code never touches "rstn" signal in atomic context, so there's
> no need to implicitly put such restriction on it by using gpio_set_value
> to manipulate it. Replace gpio_set_value to gpio_set_value_cansleep to
> fix that.
> 
> As a an example of where such restriction might be inconvenient,
> consider a hardware design where "rstn" is connected to a pin of I2C/SPI
> GPIO expander chip.
> 
> Cc: Chris Healy <cphealy@gmail.com>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>

Reviewed-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
