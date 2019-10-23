Return-Path: <SRS0=opz3=YQ=vger.kernel.org=linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3655CA9EB6
	for <linux-wpan@archiver.kernel.org>; Wed, 23 Oct 2019 15:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A911F21A4A
	for <linux-wpan@archiver.kernel.org>; Wed, 23 Oct 2019 15:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="KBoKx5yO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406881AbfJWPlE (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Wed, 23 Oct 2019 11:41:04 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35611 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406869AbfJWPlD (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 23 Oct 2019 11:41:03 -0400
Received: by mail-pf1-f194.google.com with SMTP id 205so13180168pfw.2
        for <linux-wpan@vger.kernel.org>; Wed, 23 Oct 2019 08:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=TI9rW32nt+i6GyURUSN10bGjthP0EG+xScjnb+pkqac=;
        b=KBoKx5yOJdWGZz7I1M810keaJ1ZlEuvnt+HTZJAS0UmK0LTUpPmdFTkklfgcGdi73r
         feMTzV569J5UceysOEInvWeJdRd/ZzonW6Aa3VYlqczCqXy+PY9ipoJvzLD+NWbnZ5rP
         mW2vwJLR0Vq7sY9XP/QBVZSb/GxJx9fS5CE5Yo07sdXhMNQdYvScXxROVKhe4Esy5Cvd
         e50H85g6521yumbQVB+PGX8SW/L7QzMUvgyanXK1Toe52me2wt2CIUN9qyd4f938PFQ7
         rthEsivMBKI4ftQ33yVLiM1NHSBLjKlHtZVEVP38OG7iyjy4z/skVUexYga7/45kjz+T
         6+ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=TI9rW32nt+i6GyURUSN10bGjthP0EG+xScjnb+pkqac=;
        b=c/VxRHm9uoVl0bHy7RUtLJCL7XUE/VcZeS3We1+Q+DrOS2uQ2qznrgyl5Cd+2KC5R2
         gbZhADDCLO7R8CopMlcW0uBNOPx9i89JhzcbYBea2LW58pRFnMQKTPYK1SrK9NfulbHJ
         +lbDPo7hSb/LM5vQi4T13nkgMSS9Pcszi6VkzG31tIH2/kcKwXiwmLhYPu4dQlKVVAqG
         rt3Rz5mS7XV0eH3KmJYMUNXXiKGeQoMIHhDY1wiKgQaMiw+iwsoBjtSr9AcskgRrLamK
         ndY3ib1OpVYe1LwUqMQdx5tzi3Cf0oH5zv39Ya2yqgtQ7vPZ3s0hyDFOQWd7ZZF+jo1T
         pl1w==
X-Gm-Message-State: APjAAAXL00EG0Wk6ooUsvgB34INov8nDt1Bksh0+6nefEdDH5dtqWXVw
        8RqWiPNvi+540Vy+69I5hlTbzjvNgwPU5EZ4
X-Google-Smtp-Source: APXvYqxpUg0BJf6IgZEek+Avbtx6SaPZVRb4CoPCBRhASaoQxSh7v/tZYoAbFxDTBg5wYPAauGUeIw==
X-Received: by 2002:a17:90a:e987:: with SMTP id v7mr765373pjy.86.1571845261541;
        Wed, 23 Oct 2019 08:41:01 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:15c:211:200:5404:91ba:59dc:9400])
        by smtp.googlemail.com with ESMTPSA id r18sm28682272pfc.3.2019.10.23.08.40.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2019 08:41:01 -0700 (PDT)
Subject: Re: [PATCH] Cleanup: replace prefered with preferred
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        "David S. Miller" <davem@davemloft.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Alexander Aring <alex.aring@gmail.com>,
        Jukka Rissanen <jukka.rissanen@linux.intel.com>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Ingo Molnar <mingo@kernel.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        hersen wu <hersenxs.wu@amd.com>, Roman Li <Roman.Li@amd.com>,
        Maxim Martynov <maxim@arista.com>,
        David Ahern <dsahern@gmail.com>,
        Francesco Ruggeri <fruggeri@arista.com>,
        =?UTF-8?Q?Linus_L=c3=bcssing?= <linus.luessing@c0d3.blue>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Feng Tang <feng.tang@intel.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rafael Aquini <aquini@redhat.com>, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-efi@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org
References: <20191022214208.211448-1-salyzyn@android.com>
 <20191023115637.GA23733@linux.intel.com>
From:   Mark Salyzyn <salyzyn@android.com>
Message-ID: <fa12cb96-7a93-bf85-214d-a7bfaf8b8b0a@android.com>
Date:   Wed, 23 Oct 2019 08:40:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191023115637.GA23733@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-wpan-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

On 10/23/19 4:56 AM, Jarkko Sakkinen wrote:
> On Tue, Oct 22, 2019 at 02:41:45PM -0700, Mark Salyzyn wrote:
>> Replace all occurrences of prefered with preferred to make future
>> checkpatch.pl's happy.  A few places the incorrect spelling is
>> matched with the correct spelling to preserve existing user space API.
>>
>> Signed-off-by: Mark Salyzyn <salyzyn@android.com>
> I'd fix such things when the code is otherwise change and scope this
> patch only to Documentation/. There is no pragmatic benefit of doing
> this for the code.
>
> /Jarkko

The pragmatic benefit comes with the use of an ABI/API checker (which is 
a 'distro' thing, not a top of tree kernel thing) produces its map which 
is typically required to be co-located in the same tree as the kernel 
repository. Quite a few ABI/API update checkins result in a 
checkpatch.pl complaint about the misspelled elements being 
(re-)recorded due to proximity. We have a separate task to improve how 
it is tracked in Android to reduce milepost marker changes that result 
in sweeping changes to the database which would reduce the occurrences.

I will split this between pure and inert documentation/comments for now, 
with a followup later for the code portion which understandably is more 
controversial.

Cleanup is the least appreciated part of kernel maintenance ;-}.

Sincerely -- Mark Salyzyn

