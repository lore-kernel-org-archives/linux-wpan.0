Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E02C61DA3
	for <linux-wpan@archiver.kernel.org>; Tue, 21 Feb 2023 02:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233284AbjBUC7I (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 20 Feb 2023 21:59:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbjBUC7H (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 20 Feb 2023 21:59:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420E81AB
        for <linux-wpan@vger.kernel.org>; Mon, 20 Feb 2023 18:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676948299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n1KbIBNpotJfXCgJB+Ouy0XQb8T+XF5rMr5yj07gcBE=;
        b=XajZDCQMUgRK7G14CsiUpJDv6WFsYFTGSxP4D0k0BOpDnjytrUFr7Vd4OI8eOdt/OkjKx8
        o1I/ppibxx0Kp4AKxioEXGe3qi1P4vLew+UoUeBi7eVXakfUtrMmKoAB55eSIpB6i/jc2h
        C2tIcLO/LBGX3Ab5Ve1Jf2lamyR7KLY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-152-UgZVTNjmP3usYb2v1wjMdA-1; Mon, 20 Feb 2023 21:58:17 -0500
X-MC-Unique: UgZVTNjmP3usYb2v1wjMdA-1
Received: by mail-ed1-f72.google.com with SMTP id ec13-20020a0564020d4d00b004a621e993a8so3577531edb.13
        for <linux-wpan@vger.kernel.org>; Mon, 20 Feb 2023 18:58:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n1KbIBNpotJfXCgJB+Ouy0XQb8T+XF5rMr5yj07gcBE=;
        b=qz7iF9clT78/seIaMSQE9PG5yt1l8HGMbh5HFsoRO30o014Z7w3xtJvcll61thhuaT
         fq7Pj8f0Ts1u4us9rLI46RpCQujGE6XWxzuVDk9ehGB06/NxbTJtultkJ/z0/C7wSTyg
         NZrOtCvxnXk2gk12i7XLn3LY1srjlo9vJDJwxyMDhrNtGx4fPWA8fLQiLKwZ3ZZGlFad
         CmP/L7j8/p3SNtmEL6i+B3md610dbys1HW+z+7elFNJ+LBT5hCZVruGd7F4hM2RfZHM1
         MAivOMYNlVF1/vXoaUfH9MmSncur1p50MY71dT9WETWzYkFU4Bl12fuSN5ZdUQVa+F78
         LJSg==
X-Gm-Message-State: AO0yUKXiQ2fUaBkI0TbB+EXxqMUHzVwJFq3I0D+5MtFBr5Oi8XH09hch
        gHkEf2uRNfL+nSbSj4V3RGs07ezdvxUkez2J01qDQYabmmkOSqjIGCoedefBbJRjoPvCAfUqBA/
        6w7Hca5kMCgU3NTCPJXip6eeRujGdeCQUKwOpZ38kp16wrw==
X-Received: by 2002:a17:906:2495:b0:8b1:78b8:4207 with SMTP id e21-20020a170906249500b008b178b84207mr6513981ejb.3.1676948296092;
        Mon, 20 Feb 2023 18:58:16 -0800 (PST)
X-Google-Smtp-Source: AK7set8QjH7KL5bZsB4oLZfos74u/oKTJswVale7kEE3tEPp1GN++9btrLMJofgSgPv29KXMWLOzhgJN3P2E7nJGKdk=
X-Received: by 2002:a17:906:2495:b0:8b1:78b8:4207 with SMTP id
 e21-20020a170906249500b008b178b84207mr6513976ejb.3.1676948295873; Mon, 20 Feb
 2023 18:58:15 -0800 (PST)
MIME-Version: 1.0
References: <20230217100059.58e92818@xps-13>
In-Reply-To: <20230217100059.58e92818@xps-13>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Mon, 20 Feb 2023 21:58:04 -0500
Message-ID: <CAK-6q+hUzbUi3quGW6_jvXyGm+cqv4aY6rnLOJ1B=QzOMUoH8A@mail.gmail.com>
Subject: Re: ieee802154: energy detection question
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Stefan Schmidt <stefan@datenfreihafen.org>,
        Linux Wpan Mailing List <linux-wpan@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Fri, Feb 17, 2023 at 4:01 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> Hello,
>
> I know this may sound like a silly question but while looking at the
> various drivers implementations I found no users (at all) of the ->ed()
> energy detection hook. Its comment says that the mac layer is supposed
> to use it but I couldn't find where. Of course, the fact that the
> abbreviation ends like half of the word in english "-ed" does not help
> grepping for that, but I could not figure out how useful this callback
> was. In particular since it is mandatory to provide.
>

There is no user, there was never an upstream user.

> I am pretty sure I missed something, so perhaps someone has a pointer
> to help me there.

I think there were some non-upstream users for code which never came
upstream. Please don't look into this code.

What do you want to do with this functionality? But the finger out and
look for a suitable channel to switch and operate on?

- Alex

