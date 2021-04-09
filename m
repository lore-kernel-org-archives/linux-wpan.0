Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 712C8C433B4
	for <linux-wpan@archiver.kernel.org>; Fri,  9 Apr 2021 14:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FD8A61042
	for <linux-wpan@archiver.kernel.org>; Fri,  9 Apr 2021 14:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233019AbhDIO2W (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Fri, 9 Apr 2021 10:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232855AbhDIO2V (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 9 Apr 2021 10:28:21 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22DDFC061760
        for <linux-wpan@vger.kernel.org>; Fri,  9 Apr 2021 07:28:08 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id f75-20020a9d03d10000b0290280def9ab76so745133otf.12
        for <linux-wpan@vger.kernel.org>; Fri, 09 Apr 2021 07:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+2K/CX3TjejBCDZHRJ0vbN5xIJaEON+MYGdY4oqg+wY=;
        b=FFaOEMLhRJhgtzopIuVP54Sx+CuCbfYYSYDcjB4+471+tPehu9JfFh0qEbopJSvAzZ
         Y+RD706l2C9XITGI5ADsifbf7WB+dBRRN5TpDG/OBL2jHXvfbNdg+HG7ZYqJW+5FcpR+
         vtXXtNfPqqljzZLvqfy3tDBTD144dvYxqfTti9kfKGe4PgXDBcw3l4aE0wokcAKIQVsO
         lqHMmB2MpbNKcBvBojmMIlr+0vAJV5jciI6BWvTDaA0qlMuu0i02MyKbKalspiKb6ZNo
         poyhslnjWK3mCN/IxkVKSkvFlimsK4ShucIQB3fOnI4KvZJAQmZ7xtS9w4abc8lTXp6E
         zZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+2K/CX3TjejBCDZHRJ0vbN5xIJaEON+MYGdY4oqg+wY=;
        b=VtmO8cj4uzovRZAjnWAry5DXPhYmJN+c2wjD9Sc+BCcYrGTdm4kjmnzqrhsPUTtn0p
         uUcfIR1gZxRY0i8+lDOp0EOQtmU8NUS+RsbwK6f+BAvNcUNJOIthyNDpPddB+E5kzqBD
         TQJEjEjtDWLjORbhRGJdpiNvYlO2YCMXxoN8cP7afrtFE/JkIESUrRDzs815kk/EnrZq
         fjs4sZEeUl/IS8mPKTGuBgsJvT1Xd152WeS4g14JCsXuZfgcS+n+eP2i+/GOTvQnFcqe
         pvU2ztLmuCIYA4IE7SfRQGeUYfUGQeOKfp17yKVp9U7+YGIoudTKn1q3WNhF8XNfan5x
         fGrw==
X-Gm-Message-State: AOAM533+RDjjF4V6jdlfajwqUyFyGzud2K2jtTCS+G8fXFwn9sWdmG3Y
        b6Me3al5tH3a5IhmFM4NwVxacGKhec/YoISrocnr0asN
X-Google-Smtp-Source: ABdhPJw7InyYBqOzGwYDC9hAjagiIx1vHNUsnC+Lk7Eza00BQHQeY1QKD4XcezM8ul5R6cAxJN32nAL0uLC/ehL8kqY=
X-Received: by 2002:a05:6830:111a:: with SMTP id w26mr12047932otq.329.1617978487535;
 Fri, 09 Apr 2021 07:28:07 -0700 (PDT)
MIME-Version: 1.0
References: <SN6PR01MB3648B4FC16E10CA1B04F756587749@SN6PR01MB3648.prod.exchangelabs.com>
 <CAB_54W7K7ir+CLxMkXGMYbxuvDEEJD5vNW2arbLLiaSKrGtbLg@mail.gmail.com> <SN6PR01MB3648AD0120B58D72E5B0C00F87739@SN6PR01MB3648.prod.exchangelabs.com>
In-Reply-To: <SN6PR01MB3648AD0120B58D72E5B0C00F87739@SN6PR01MB3648.prod.exchangelabs.com>
From:   Alexander Aring <alex.aring@gmail.com>
Date:   Fri, 9 Apr 2021 10:27:56 -0400
Message-ID: <CAB_54W4j7G53YT8G32GdM4pNET8i0v9_zkNMe=0dwdfbHvEXFg@mail.gmail.com>
Subject: Re: things not working - newbie questions
To:     Mark Butsch <Mark.Butsch@myfuelmaster.com>
Cc:     "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Fri, 9 Apr 2021 at 09:29, Mark Butsch <Mark.Butsch@myfuelmaster.com> wrote:
>
> Hello,
>
> I ran the bash script you referenced, but was unsure of how to test.
>

okay, forget that bash script please.

> I also tried using the mac802154_hwsim driver without the separate namespaces.
>
> I took it as far as creating and bringing up the wpan's and they show up in ifconfig.
>
> Then I tried using wpan-ping, but got time outs like I was seeing with the real hardware.
>
> Ifconfig shows one phy with the TX packet count increasing and the other with the RX packet count increasing like I saw with the real hardware as well.
>

please tell us all the steps which you are doing with mac802154_hwsim,
the good part of that I can type it here as exactly what you do and
then I can tell you why it's not working.

- Alex
