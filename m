Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF09C433B4
	for <linux-wpan@archiver.kernel.org>; Thu,  8 Apr 2021 16:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92EC06113D
	for <linux-wpan@archiver.kernel.org>; Thu,  8 Apr 2021 16:47:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbhDHQrW (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Thu, 8 Apr 2021 12:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbhDHQrV (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 8 Apr 2021 12:47:21 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1701C061760
        for <linux-wpan@vger.kernel.org>; Thu,  8 Apr 2021 09:47:09 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id s11-20020a056830124bb029021bb3524ebeso2986328otp.0
        for <linux-wpan@vger.kernel.org>; Thu, 08 Apr 2021 09:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7/WrIjESMPXX+4eQMKlR9R0g5XR6nCXDghXlHxRYhKU=;
        b=MC9c3fA7cUKEqFO5CymT6lvrnb/3QXmplg7UXOsa97UGq02QtmgYF2lxMjdL0qbIc/
         C3at5Z8v2GdqiQmxqDZzoMsBDyUOr0/SSsPlrYK9x1f7lyVoZFDFnSdVAGGzCZHcvHrs
         82zsWoPCMyFh1iOcGxWNk02rtigB9TmcGsVJ+hZdDxZwzgFFM3UvbRaRiDFHptZYcK1m
         +rCpP6fe6sZx6IQCQC+ZU8cFOhL5pPdFk75KR2qHhMFYfL82Mb6+Ingw+H9akyyyrN/t
         raxzB/Sdcjd0iVnY8WWfXYqlycrz1PCFHzYvAhGgFVoXMzqLvuomNUW6ZtruXGiMXEXb
         eFog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7/WrIjESMPXX+4eQMKlR9R0g5XR6nCXDghXlHxRYhKU=;
        b=ncyxxwjmnrDRICURgSfoHBN1mW0L4WJkwuR64SQMK1C5ehF8du9hnbvhER4kQc57MF
         dl7NM/ZjQ+++GURBvo/GgbTsBF6kLkK33nzuOUA3SOX3ksNp9+vQ7TcT6ACri8G/Mz3I
         m/BQ2ezX2cZBSKwZgl4t55gJxl9Rw0uTXuh0whMTKy+Jnjv6Jn3TxTWO0gUn4gDrsI7s
         +BI/9R5oA+cCENCvd5qXyMj5Y4h3QEnHKAhOEbGQPj4up4pRj3qukL80YJ0159G6b2+Z
         5HYCKBJ16EKWw2D0sCBycBmfixNkUIDgV85CJ7zBuPxM43Dngp/dtSIf0zIVx2DLjpUV
         HDig==
X-Gm-Message-State: AOAM530a3UEJcA8YohrIjcRCenj5aYN+AYI7cWVn4O9DdJ5syjwidGGf
        DPHKkHV9a7zsYEcgvoWKOG/fSpw5X0m8AngzQJ01dqJN4QU=
X-Google-Smtp-Source: ABdhPJyV20TUc5SaWozEUHmSe+fpLlWABbFK+LvL3zChxh3pAHw7CIeHECJPqEL7fpB7ZM3jKtHqSFdR3BkjPVwwq+k=
X-Received: by 2002:a9d:70ce:: with SMTP id w14mr8378306otj.183.1617900429397;
 Thu, 08 Apr 2021 09:47:09 -0700 (PDT)
MIME-Version: 1.0
References: <SN6PR01MB3648B4FC16E10CA1B04F756587749@SN6PR01MB3648.prod.exchangelabs.com>
In-Reply-To: <SN6PR01MB3648B4FC16E10CA1B04F756587749@SN6PR01MB3648.prod.exchangelabs.com>
From:   Alexander Aring <alex.aring@gmail.com>
Date:   Thu, 8 Apr 2021 12:46:58 -0400
Message-ID: <CAB_54W7K7ir+CLxMkXGMYbxuvDEEJD5vNW2arbLLiaSKrGtbLg@mail.gmail.com>
Subject: Re: things not working - newbie questions
To:     Mark Butsch <Mark.Butsch@myfuelmaster.com>
Cc:     "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Thu, 8 Apr 2021 at 09:59, Mark Butsch <Mark.Butsch@myfuelmaster.com> wrote:
...
>
> Understood. Probably best to focus on resolving the wpan level first
>

You can try to use some virtual hardware driver to check if there are
no setting failures whatever you are doing.

Load mac802154_hwsim. _Maybe_ it's required to move it into another
namespace (for ip sometimes yes).
It will register two phys (by default) who should be able to receive
to each other, see [0] for an example.

- Alex

[0] https://github.com/linux-wpan/rpld/blob/nonstoring_mode/test/ns_setup_simple
