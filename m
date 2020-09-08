Return-Path: <SRS0=Rh/c=CR=vger.kernel.org=linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D4BC43461
	for <linux-wpan@archiver.kernel.org>; Tue,  8 Sep 2020 05:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25CC62076C
	for <linux-wpan@archiver.kernel.org>; Tue,  8 Sep 2020 05:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="EBbjiswI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728726AbgIHFzj (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 8 Sep 2020 01:55:39 -0400
Received: from mout.gmx.net ([212.227.17.20]:54739 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728531AbgIHFzg (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Tue, 8 Sep 2020 01:55:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599544534;
        bh=J3uUIqatYYMuHkR9Fpyx/qeJI0OjWjLUARlM4Jgt2mg=;
        h=X-UI-Sender-Class:To:From:Subject:Date;
        b=EBbjiswIsiq9IS42bpK0HuczQ4JRXs53nU3dio+Z5KzaNq6KItMPbMQitBcYvxLVS
         i6JnDXJaf3fElGUFAgkzgQOEbPPxtbiL61fi9/2KqIBfGdKYFRC2QupJ8Rx9jzALIq
         Z11ZAm5RoC/a4Bh/AlflE1X3CnUpoeXBNWWHhXkM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.45] ([178.10.251.51]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N7i8Y-1kbCM80FVq-014jfh for
 <linux-wpan@vger.kernel.org>; Tue, 08 Sep 2020 07:55:34 +0200
To:     linux-wpan@vger.kernel.org
From:   Achim Kraus <achimkraus@gmx.net>
Subject: 6lowpan Support for Raspberry PI 3B+ - CYW43455
Message-ID: <f1acad10-2fb3-a402-df58-907c2580c5ab@gmx.net>
Date:   Tue, 8 Sep 2020 07:55:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-AT-frami
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+4ku38BoxFcMbAKhMmCltFV6XnLSfJgD5skNKW8rK0T62CYOooi
 Y6s/FMUyDOfNS40GmhPR5a+TweEwXsiaeaPrWR8lzOo5KNVZvyPJEPHduAUcCjKQPCMVFP3
 r8JKoRov+dMX9nsMGi0zG1dGPVFtbTCYP9/sVypmt2jFgwfi8F2v2YGAY3QQEUUKzZe/fAw
 eT6tRNan8u8awX+4DU0Bw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xZYnFF14o6U=:XJq08J2VusQKPwW/nU337d
 7uxBBNSjlnxYgaFwoxDl42P0OfUcu/k15ab9gNVLiPmIoPsIYXM4Nf3qbeiKL6V8YbdtPj3p4
 3hhhsJkZYdi+n/Uoi0ZLhzmW1mnKHivUhbLEP14Zm5mLexeiszsYXL7gHqwcgd+LqKGW+icPc
 x1X25kLJe1N9AGVhGreKKp/PqQLtn0lYSoaS/TRTLx6dmtr/xZziRjtaqU1G5q0/NM4oZwkfl
 y9XJ6zifEsL56F5q2n3s/as84viDptDX9OMv1poEoLKWVbWxJXq41W9g7M7iHatAcr59XRrhG
 Bv15ma/IibGlEasrzzPFVvQgDJhAGosOxy98aQbBx43j1tDo1RkAukO6rUWH72TjCVFAF4DgJ
 sAVeaSYYdbkIjgXhezcGqzUKn5uuUW8HoHf8d95YMfAtKbqcC0HEik0tUgHGqQntgGdYyjJKr
 fZ9OHzN+L8cTDiAtddvpe4dc7B5Ukf0h5Ej15sacSzABRduDT9QJQY77dYqhMw4RFRclJebba
 EVzdc9eG45cR8JTuZNv24Xzn6hnuUclqgdgKkQdYELQMKvU6ZyE7KjYLkQJ/S/PdXRguicwUE
 EGuctvaV+pvJCvTHz3yaCvytxWOF2a2yEQyJGF1g9gKwb2msJAsO1C5649suCCLMjoxKjuVFd
 rbcSNPNfbUiLMxK13VMnc0FJujqOUJvjRLP14chJE/Rmha6E5h4Q3w2ttJ1rVD6yICkR/M0L0
 CiiGM0lzXpOh/t97ppDiJyCKyYf7ar3wGGPZmS8ZJH//Iavirih25BqtlwBmrews+MXfMa0bM
 n7SN3odVYM0a7Wuh//jH6nK+zJkOz6hc2XGbuCa9XQCxfon7JQfHqp3G3b2RSNJZ8OJso0PyU
 Up7WB19MahNM8NA8kqerRbIt1Q+5hY6lQ7VVc6Z3QdmS23/ipKqxCQJTmNrQdUWcVc5xlXE2q
 R2oyRdex5td3uyUWlxOrGKyQ/O7tHjWFsUolP5peIO2QtnuwsSdbAM11tjR11VJf7mtvnT6Iz
 G0BNOaJxSKNVZv1LNZTch97o6PXYMnUf0WzjyLUp8JSMDJ5+PpXLS9HGGCxofsRxmu30i8v/v
 Syw8heuxmkQTxc81m0F2RsDKrhTb/mjEs1shW9dmtQDiclrTu+DZMsTCNIReiCqRZspu5Kkuc
 DcyAjLkefJ20OysdYUTe/UZTLQUo3T4ZastOOj4R5RYKgl3Oh+KBZp+oOAhlb0T9hubn+ACqO
 wdteQpHaZE/1aAYa7XD5dVxHSoRYBGb/yU0KSJA==
Sender: linux-wpan-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Dear list,

spending some time in evaluating the current state of the 6lowpan
support for Raspberry PIs in order to use it together with
Eclipse/Californium CoAP/DTLS (I'm a committer in that project),
I found a lot using an external modules.
But I'm wondering, if there is any native support for a Raspberry PI 3B+
with a  CYW43455.

According articles as:

https://www.linux-magazine.com/Issues/2018/212/Raspberry-Pi-3-B/(offset)/3=
/(tagID)/383

"Bluetooth 4.2 takes this to a whole new level: The IPSP-supported
6LoWPAN (Internet Protocol Support Profile/IPv6 over low-power wireless
personal area networks) takes IPv6 to small, low-performance devices for
integration into the Internet of Things."

it seems to be possible for the hardware, but I could not find hints,
that it is working with the software. According

https://linux-wpan.org/hardware

it's not listed, but the nrf52840 is also not listed (but working with
the openthread setup from nordic).

So:
Does someone have tried to use a Raspberry PI 3B+ native CYW43455 for
6lowpan?

best regards
Achim Kraus

