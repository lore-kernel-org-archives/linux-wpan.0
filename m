Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B919C433EF
	for <linux-wpan@archiver.kernel.org>; Mon, 13 Jun 2022 03:44:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbiFMDob (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sun, 12 Jun 2022 23:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiFMDo3 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 12 Jun 2022 23:44:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 16C3012626
        for <linux-wpan@vger.kernel.org>; Sun, 12 Jun 2022 20:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655091865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=weXT1rak57v1x/fmYaFf0QEuHeZHnRVcN5IqDOdhHmg=;
        b=S1Bye4NXV4essalV/ElxoMGpwSSGmJU3JiMV5NIyaMzSLizemYeTONhi7Yo5Tp1kGd5Zm+
        1NdiQMaTFTQVcVnctQG029HOgq4afFf4ysoI6Flx4qYgF3eQKlOgsoBltSIPASeVIqI7Zj
        MUYyFICn7TXGkhVoi61iyre9UZ8x41U=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-199-aCqPIyWdMrGKdnt9s-_3yQ-1; Sun, 12 Jun 2022 23:44:24 -0400
X-MC-Unique: aCqPIyWdMrGKdnt9s-_3yQ-1
Received: by mail-qk1-f198.google.com with SMTP id bk10-20020a05620a1a0a00b006a6b1d676ebso4165525qkb.0
        for <linux-wpan@vger.kernel.org>; Sun, 12 Jun 2022 20:44:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=weXT1rak57v1x/fmYaFf0QEuHeZHnRVcN5IqDOdhHmg=;
        b=7063QlRjVfA5SxY+CR9M7BNrnHPL1xkiSYmDfAs/SAm2JGtb7dQ82pH6HHHybCSGdq
         Cxu4xlREj6NvPyGxY9lhNpmOVx1/qJnalookBKyQfFX0c/Jf1mwIJ71t1TLZ7KPh3YZP
         n8MMn60md1DxuEVA/TJO+rvfsYAdUz2sMn+ouFb1nAC0VebVkw9/B3OSma0NwZTvSjlI
         bjy5Vwhy/BBKErLc56+B/JmBe7wJ/f2xBr4hPafYZjJsGy5C/twRwMvTKbVdz1CCRDNZ
         EuPe4RrvBccdgK7XHmhWwid+BtGQd/yYTh7D+9hx3sa0WwympO7tOB/MmM07D/6fM3hH
         6ZLA==
X-Gm-Message-State: AOAM530z9Utk/9PggxvQ7tjBLd7caDE+10q4YwX0nLNrYHZ4HM8Cb1kj
        tL1XMWw//lYi2FgN7D/zgyM0PWT6xEXA7FDdW9BKyUjOcORb1iCtBj6u2E6Z2RE0HAzZhceaSPm
        2ZKa+yTX2ENDAtA4U8YzUAXV0vQ0eSSneIiR4iA==
X-Received: by 2002:ad4:596b:0:b0:46b:cc90:5a87 with SMTP id eq11-20020ad4596b000000b0046bcc905a87mr19496162qvb.59.1655091863479;
        Sun, 12 Jun 2022 20:44:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyIi5pOuNEZ8Veo/mZ6QmYCxHGYpHW1nGkcu13a17EX7kUGNU/tdFjsSbkbBEdepNyGjhb0WwcHU2NrKQVvcnY=
X-Received: by 2002:ad4:596b:0:b0:46b:cc90:5a87 with SMTP id
 eq11-20020ad4596b000000b0046bcc905a87mr19496155qvb.59.1655091863284; Sun, 12
 Jun 2022 20:44:23 -0700 (PDT)
MIME-Version: 1.0
From:   Alexander Aring <aahringo@redhat.com>
Date:   Sun, 12 Jun 2022 23:44:12 -0400
Message-ID: <CAK-6q+g1jy-Q911SWTGVV1nw8GAbEAVYSAKqss54+8ehPw9RDA@mail.gmail.com>
Subject: 6lowpan netlink
To:     linux-wpan - ML <linux-wpan@vger.kernel.org>
Cc:     linux-bluetooth@vger.kernel.org,
        Network Development <netdev@vger.kernel.org>,
        Stefan Schmidt <stefan@datenfreihafen.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi all,

I want to spread around that I started to work on some overdue
implementation, a netlink 6lowpan configuration interface, because
rtnetlink is not enough... it's for configuring very specific 6lowpan
device settings.

Thanks.

- Alex

