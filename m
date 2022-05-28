Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E0DC433F5
	for <linux-wpan@archiver.kernel.org>; Sat, 28 May 2022 15:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244839AbiE1Psy (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sat, 28 May 2022 11:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233172AbiE1Psx (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sat, 28 May 2022 11:48:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CE95312A
        for <linux-wpan@vger.kernel.org>; Sat, 28 May 2022 08:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653752929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5GAhpNoL6mVubSpwZ4APr5XIqQJTwS8OwKgO1Q7qWXM=;
        b=dZdtc9faiWDozjJPa+MUOQ8Ltp750xU6GcX/ayYXhB3tOExhpKRD7abRY3vbj02lsZD9jq
        JVCR6ELvSvY3/4xnLu8CA4O2d7FSEhu931dye2U0mu6GZ3y2aMYdmGlGqyE0eqZJ4xifPV
        yzBdmSOFa5JVld4xvWszgX8djRt44rE=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-613--oCKg88kMfevRnRXaOX5lw-1; Sat, 28 May 2022 11:48:48 -0400
X-MC-Unique: -oCKg88kMfevRnRXaOX5lw-1
Received: by mail-qk1-f200.google.com with SMTP id c8-20020a05620a268800b0069c0f1b3206so5896952qkp.18
        for <linux-wpan@vger.kernel.org>; Sat, 28 May 2022 08:48:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5GAhpNoL6mVubSpwZ4APr5XIqQJTwS8OwKgO1Q7qWXM=;
        b=PLjTFIJOTbFxHp7JgP+e2s1hzJxZ4K5T+I4AhqvdCG45pI7Yg8RyKA0bZNCArRP3tW
         6yyx2C+2xXAPLpzPDx7QT/+/+2CHY9d/Qzl+UCaB7MafKdCGGpnfHhAThyo/wwSPwRs/
         0I8TMpLJSz9eh4Y12PGDj63+z0O8WbAG3ynIKLmf6N2ftm2fIdERz7rr7H+HbWoXEX+S
         fcnZsv0MrRT5ZB1QoYRh2D7oVzSq5j7q8aG1/PuGF+cDlkqnfF0uN+yufzfU1ZmfhSeC
         0E5B9QG5YAH45GLxAl+BkeKdT0we6+N8cBMFQugj+3HVHd0VQAUAccvatxRR1risg+6B
         h9Wg==
X-Gm-Message-State: AOAM530uiSm4Lo/07Ma4AWrjlxeGJVNP7BPkP/2VYXVbduhRtU4XhzHU
        14XO8xYwGVZHXai31ow8OpgdRec1Ui+mWNpOf5xY8VD66lxTSdOGWCvCjLse9rxelxmbk7w/Hba
        GiyhlPQQosv+uRkntqNDuA9BkWW5w5/6K+9Msyg==
X-Received: by 2002:ac8:5750:0:b0:2f9:410b:7101 with SMTP id 16-20020ac85750000000b002f9410b7101mr19892461qtx.291.1653752927535;
        Sat, 28 May 2022 08:48:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwmAsucB7ng/+qB+vvkMRhBKq3xcdUohmtwPZcqjrboA1dOIsdMeoqf6NSF/fuav7Oq7do5fGX9GQQTQ5RsLU8=
X-Received: by 2002:ac8:5750:0:b0:2f9:410b:7101 with SMTP id
 16-20020ac85750000000b002f9410b7101mr19892448qtx.291.1653752927345; Sat, 28
 May 2022 08:48:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220526162806.16618-1-jukka.rissanen@linux.intel.com> <20220527075625.9693-1-jukka.rissanen@linux.intel.com>
In-Reply-To: <20220527075625.9693-1-jukka.rissanen@linux.intel.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Sat, 28 May 2022 11:48:36 -0400
Message-ID: <CAK-6q+icAttyjPFx6LXLTUu4b6WBpj9kwKNxUS9WE=cPz6=DnA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Remove Jukka Rissanen as 6lowpan maintainer
To:     Jukka Rissanen <jukka.rissanen@linux.intel.com>
Cc:     Alexander Aring <alex.aring@gmail.com>,
        linux-bluetooth@vger.kernel.org,
        linux-wpan - ML <linux-wpan@vger.kernel.org>,
        pmenzel@molgen.mpg.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Fri, May 27, 2022 at 3:58 AM Jukka Rissanen
<jukka.rissanen@linux.intel.com> wrote:
>
> I no longer work on this so better update the file.
>

> Signed-off-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>

Acked-by: Alexander Aring <aahringo@redhat.com>

:'-(

- Alex

