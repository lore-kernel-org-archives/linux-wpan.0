Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E3EBECAAA1
	for <linux-wpan@archiver.kernel.org>; Tue,  6 Sep 2022 00:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbiIFAQi (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 5 Sep 2022 20:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiIFAQh (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 5 Sep 2022 20:16:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1E650051
        for <linux-wpan@vger.kernel.org>; Mon,  5 Sep 2022 17:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662423396;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4gNVfF4gesiI/AlrFvrmpQSjyLZ3+aQ2ZKLu5NThtzI=;
        b=IND+Ayt1I/mvp2mhQmr1OA1Qw4WBJk5LNSIqTloeJGKmVHuTajZuuSQizezyqaueIzYTFB
        ZFET9AOu0WV6uI17pABgZkbT/sPBNRVqt+iKrgLNDIV2NxOvC0ZeCqXICRd8At6Zchc62S
        XnILYRwvUyeKLjQR9h0KBogJvxVp3RE=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-511-5jBnkT8PPsegEwia1CfDyw-1; Mon, 05 Sep 2022 20:16:32 -0400
X-MC-Unique: 5jBnkT8PPsegEwia1CfDyw-1
Received: by mail-qt1-f200.google.com with SMTP id v5-20020ac873c5000000b003434ef0a8c7so7849469qtp.21
        for <linux-wpan@vger.kernel.org>; Mon, 05 Sep 2022 17:16:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=4gNVfF4gesiI/AlrFvrmpQSjyLZ3+aQ2ZKLu5NThtzI=;
        b=VeKN/NY7hg6x86puaCHLUz7illtnDvxISb9cabQbNhQI/Nor2IqIcDC+Pkolc4BuUx
         RpGFNt1uTh5ifV7Hu1pZ/LfruVJ68/TH9ktFtWKUEG+wDvVLtnntUdgAr4cU1EnH/eJo
         UvHRhaaG6nARHs9vXg31fxcAgvVB3qsg88AiEFtwNabTz9rudzaDIc/mlVbF6eXxEEAh
         q8udEyRiRaZiOHo9Q005YhwHSIhd6D67hvUvyPsn39hYkaH8tQQcm3IJHHqhnQQnv9lU
         jdZx4qe2VYCFqNWYjle5uqiUeaUFbcTN94SQAdGM/WNq4OaAwG/T3lypkrk9U6E2HqID
         7dwg==
X-Gm-Message-State: ACgBeo198IsUfIlt8e8gJHgpKDUrmViz3ZYOKlpOPK2vepaMN/6Rokjh
        Ue1pQoOmhlU0fKC4GAn9l/b2aj2icdcPVxwxzCVtLiO54OUpMP8d/T08crR16iozHp3cUrHoKIF
        EewA/Bl4SoVh1W3P3HUYuLRSAie9tKHjoi4KdAw==
X-Received: by 2002:a05:622a:4:b0:344:94b7:a396 with SMTP id x4-20020a05622a000400b0034494b7a396mr40719090qtw.123.1662423392355;
        Mon, 05 Sep 2022 17:16:32 -0700 (PDT)
X-Google-Smtp-Source: AA6agR59bqdMxDMS5c3vl6zeV2JfZEvAgQixwVgviLhhtQEd2n7GCHvKocJrwH+5b8t6Wdh0ZEm0xLgLrecrWRSC4gA=
X-Received: by 2002:a05:622a:4:b0:344:94b7:a396 with SMTP id
 x4-20020a05622a000400b0034494b7a396mr40719077qtw.123.1662423392158; Mon, 05
 Sep 2022 17:16:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220905204318.1324284-1-miquel.raynal@bootlin.com> <20220905204318.1324284-2-miquel.raynal@bootlin.com>
In-Reply-To: <20220905204318.1324284-2-miquel.raynal@bootlin.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Mon, 5 Sep 2022 20:16:21 -0400
Message-ID: <CAK-6q+jXWgEbZ_2kyOh-Jh4N1+d6owMbRn0e637MPMt+3+779g@mail.gmail.com>
Subject: Re: [PATCH atusb/fw 2/2] atusb: fw: Provide TRAC status
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     werner@almesberger.net, Stefan Schmidt <stefan@datenfreihafen.org>,
        Alexander Aring <alex.aring@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-wpan - ML <linux-wpan@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Mon, Sep 5, 2022 at 4:43 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> From: Alexander Aring <aahringo@redhat.com>
>
> Upon Tx done condition, returning the sequence number is useful but we
> might also return the TRAC value which is needed to ensure that the
> packet we sent got ACKed. The TRAC register just needs to be read when
> the TRX_END interrupt fires.
>
> We then need to send this information as part of the status
> message. First byte remains the sequence number for ensuring backward
> compatibility and a second byte is added to forward the TRAC register
> status.
>
> Signed-off-by: Alexander Aring <aahringo@redhat.com>
> [Miquel Raynal: Moved the data array out of the stack, wrote commit log]
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

I sent another patch v2, it should also fix a race see commit msg
regarding RX_AACK_ON. May you can fast test it and feel welcome to
resubmit it as a patch.
This patch has a lot of generated/compiled files added and I think it
was an accident.

- Alex

