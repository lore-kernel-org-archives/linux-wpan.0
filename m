Return-Path: <SRS0=TYGC=7H=vger.kernel.org=linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A44A7C433DF
	for <linux-wpan@archiver.kernel.org>; Mon, 25 May 2020 12:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 770782071A
	for <linux-wpan@archiver.kernel.org>; Mon, 25 May 2020 12:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LcBsZoeC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390534AbgEYMjm (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 25 May 2020 08:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390488AbgEYMjl (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 25 May 2020 08:39:41 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E942C061A0E
        for <linux-wpan@vger.kernel.org>; Mon, 25 May 2020 05:39:41 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id c16so18487337iol.3
        for <linux-wpan@vger.kernel.org>; Mon, 25 May 2020 05:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=pxHotUkcyFOHbcQKUf+Xj5LrOiEv/2gWXvynvhtr+ag=;
        b=LcBsZoeCoXK8Fhme2V6bgdwkHHaxFRHJc/ScV3ITU4ffm4XDpXK43K4rueG6v3q3dl
         XOQ85B1+Os51Zpey3PG5/GiP1Etfy9vkkkVJ92kkEXWI3ZM1zHyC2GChfyoGJOoPg4dV
         QPT0X1d9YTUOvJ4he3WLQZo5DuCaeJYt8FyFa9oc1jZRnxqObZjz6T6SNYOMfhYhoVyx
         0GsYHdWYxTtzrq/9iQJGT1TAAWPG/nl6wHYv8Qzz3NGzd9BBHz5HUohINKTt7YdgjyCB
         9t9NUW68ZUwlD9I4HP4/3rPB0DowXE65Jazf7ZorWxij/eUFThH92Mc4abeItGxFlhdK
         3yEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=pxHotUkcyFOHbcQKUf+Xj5LrOiEv/2gWXvynvhtr+ag=;
        b=JXZDIuIAplS+cEBsREBFq4u15Njg5qIaezEa+3/6l/PUrWXBYH8+JJyUIee/J+QTcS
         X2WCFlBZxsJLkM8klGW8yYeglgf5NLYqtNnRwFTlWzjpEhDTwHu9OIH5LQebE4UTBvqu
         4QBAIEv57ObewdnihjeFD/QSMZLjfcVQ41tQu9544gOb4Er/CgEHw+TxxrjNXyuEjmFD
         wC2KzDPvdLAqjdaUvExbVX6HQn5bVuOEiGS9NVSG5BYFzHhHctksMIbYpSvVo9AjkaPn
         b9tprySJq/YJDHZL04PKDmpjT1+fXzf+maR7MSV7K+shupwA6D50oeunbzeyQHE9r5Ea
         kthw==
X-Gm-Message-State: AOAM530vIrhDdWrAznz8Lwo3zJIEJeLjZZxg+rH+MH6XuwZFhPh3K53Q
        JP18nmyb3QKPVicNB98wG9scDz4WBGsI/8i1BtlWeYyShs4=
X-Google-Smtp-Source: ABdhPJxsNj8kpRPwUgfDUYyqlNT5EBjOaGD4Tor0eXyM9Jv9SOwPRSIRQ+z5e5Q0pRARAWZSkZTVJrzWZrM6qBHZVbE=
X-Received: by 2002:a6b:8d44:: with SMTP id p65mr5717360iod.24.1590410380803;
 Mon, 25 May 2020 05:39:40 -0700 (PDT)
MIME-Version: 1.0
From:   Christopher Friedt <chrisfriedt@gmail.com>
Date:   Mon, 25 May 2020 08:39:30 -0400
Message-ID: <CAF4BF-SFHA=mPHLxpDHGMLvgu0UKO-6ujfYB+n2a6=XhFvT6DA@mail.gmail.com>
Subject: wpanusb?
To:     linux-wpan@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wpan-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi all,

Bouncing around a bit, but in Zephyr, there is reference to a
"wpanusb" Linux kernel driver here:

https://docs.zephyrproject.org/latest/samples/net/wpanusb/README.html

This *might* be the driver in question:

https://github.com/finikorg/wpanusb

Just wondering if anyone has made any attempts to submit that, or
would that go directly upstream these days?

Hope you are well.

Incidentally, we're hoping to do a microconference at Linux Plumbers
again this year again, virtually of course.

C
