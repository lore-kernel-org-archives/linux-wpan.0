Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA5C5C433F5
	for <linux-wpan@archiver.kernel.org>; Fri, 24 Dec 2021 19:57:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353464AbhLXT5y (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Fri, 24 Dec 2021 14:57:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239476AbhLXT5x (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 24 Dec 2021 14:57:53 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F5DC061401
        for <linux-wpan@vger.kernel.org>; Fri, 24 Dec 2021 11:57:53 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id j11so19159120lfg.3
        for <linux-wpan@vger.kernel.org>; Fri, 24 Dec 2021 11:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to;
        bh=sDxoFSrEcd7FWd9REkuuWUD/j4yMqKQ3xk62eFqvT+0=;
        b=D3SheZbNF78xBJKeen09SZYR5vRndtJQjtfTJfsCvCZoloFqFCtHwaQE42+sWNG6TV
         hKo4/NoeuJrMF5HOMJ5+wCXqIgtcI/ja/O4kvqV6SvnonDvyO9vpjUVsNm+AHSEXxkE8
         8SuRPUTYE7rvvKWEQLE78vqMwHt0t9vlnGT/zjAm5COMxhIWQhTiF3Eui4LS1nVbl9u+
         AuXkLbRC6cLPwAjuCLVLxa4ftyUOY5z7hK0GoPCuZ6vImkEOh+EaUoY++AfSeAlEwcvA
         FRcmBgWTpqzafO6ahjKFrCjkStsqVDu1dROvOfuN+y5u3SWPxpt4CQMvL1Q7j9emb7BP
         GdRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to;
        bh=sDxoFSrEcd7FWd9REkuuWUD/j4yMqKQ3xk62eFqvT+0=;
        b=tyVHFdSW5ctQRD4l7OCwh9cInaFdZ8OyJbkVpwB1IOhAjWjouzmWrSsiYzGs53e8Wj
         NyTf8EIiR1mhzJjV4z6K4h3YYbOEDF0iYj5epUh0zlLEjxs4ZAzqzrTsF8UDcCL384Tb
         B8jaXgU4GR0Kx1gmvSSNiFT11v82O8cvdqPJfJSBOZKnlzqeIlATl/XWLBsUj9J1s7eV
         Ec0ef+57skXEC5HK1oPF2/OvqXgckBFa69UeQ89edIvDMQI4vqPS53iZOAwnM7gxNEsB
         nUaxlPMNX0CExg67zbg7f7nfC7NBdLzsr7KjeVnTU6L3l48mx19Yx6oX3scxZZ71TRla
         RBfQ==
X-Gm-Message-State: AOAM532DE+ouUQaejh8hBUdok1CSQ4NPhO+QJoSoB1maPmV2Fdwf8k43
        bEi60FdVYPVfFqXoGSVNUIlOnCG9IKc=
X-Google-Smtp-Source: ABdhPJwQQ6N/ozFrhgbWGc+GLl4p1Z8tthiHcysOfUaLOLC83t23lpq+Qg+dPjo92tl7I7aQnVKXmQ==
X-Received: by 2002:a19:380e:: with SMTP id f14mr6400796lfa.612.1640375871288;
        Fri, 24 Dec 2021 11:57:51 -0800 (PST)
Received: from [192.168.1.11] ([94.103.235.97])
        by smtp.gmail.com with ESMTPSA id g13sm624313lfr.237.2021.12.24.11.57.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Dec 2021 11:57:50 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------0yDdLORdt2pZG9ogRqTUpcCN"
Message-ID: <913852cb-a1c2-eb69-1e5d-67867b79a357@gmail.com>
Date:   Fri, 24 Dec 2021 22:57:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: Use of uninitialized value in atusb_set_extended_addr()
Content-Language: en-US
To:     Alexander Potapenko <glider@google.com>,
        David Miller <davem@davemloft.net>, stefan@datenfreihafen.org
Cc:     linux-wpan@vger.kernel.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
References: <CAG_fn=VDEoQx5c7XzWX1yaYBd5y5FrG1aagrkv+SZ03c8TfQYQ@mail.gmail.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <CAG_fn=VDEoQx5c7XzWX1yaYBd5y5FrG1aagrkv+SZ03c8TfQYQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

This is a multi-part message in MIME format.
--------------0yDdLORdt2pZG9ogRqTUpcCN
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/24/21 22:24, Alexander Potapenko wrote:
> Hi folks,
> 
> KASAN* reported a use of uninitialized value in atusb_set_extended_addr().
> The value came from kmalloc() in the same function, but then
> apparently atusb_control_msg() returned 0, leaving `buffer` intact but
> also avoiding the ret < 0 check.
> Then the buffer got passed to
> ieee802154_is_valid_extended_unicast_addr(), which used it in a
> comparison - at that point KASAN reported an error.
> 
> * - this is an experiment to make KASAN detect some limited subset of
> bugs caused by using uninitialized values.
> 
> Full report is below, I am not sure if it's enough to kzalloc the
> buffer, or we'd better check the return values more carefully.
> 

Hi Alexander,
thanks for your report

I think, the right fix is switch to new usb API, since it cannot read 
less bytes than was requested by caller.

Only build-tested, just for thoughts




With regards,
Pavel Skripkin

--------------0yDdLORdt2pZG9ogRqTUpcCN
Content-Type: text/plain; charset=UTF-8; name="test.ph"
Content-Disposition: attachment; filename="test.ph"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2llZWU4MDIxNTQvYXR1c2IuYyBiL2RyaXZlcnMv
bmV0L2llZWU4MDIxNTQvYXR1c2IuYwppbmRleCAyM2VlMGIxNGNiZmEuLjE1ZjM4NzI2NmUx
OCAxMDA2NDQKLS0tIGEvZHJpdmVycy9uZXQvaWVlZTgwMjE1NC9hdHVzYi5jCisrKyBiL2Ry
aXZlcnMvbmV0L2llZWU4MDIxNTQvYXR1c2IuYwpAQCAtODAsMTAgKzgwLDkgQEAgc3RydWN0
IGF0dXNiX2NoaXBfZGF0YSB7CiAgKiBpbiBhdHVzYi0+ZXJyIGFuZCByZWplY3QgYWxsIHN1
YnNlcXVlbnQgcmVxdWVzdHMgdW50aWwgdGhlIGVycm9yIGlzIGNsZWFyZWQuCiAgKi8KIAot
c3RhdGljIGludCBhdHVzYl9jb250cm9sX21zZyhzdHJ1Y3QgYXR1c2IgKmF0dXNiLCB1bnNp
Z25lZCBpbnQgcGlwZSwKLQkJCSAgICAgX191OCByZXF1ZXN0LCBfX3U4IHJlcXVlc3R0eXBl
LAotCQkJICAgICBfX3UxNiB2YWx1ZSwgX191MTYgaW5kZXgsCi0JCQkgICAgIHZvaWQgKmRh
dGEsIF9fdTE2IHNpemUsIGludCB0aW1lb3V0KQorc3RhdGljIGludCBhdHVzYl9jb250cm9s
X21zZ19yZWN2KHN0cnVjdCBhdHVzYiAqYXR1c2IsIF9fdTggcmVxdWVzdCwgX191OCByZXF1
ZXN0dHlwZSwKKwkJCQkgIF9fdTE2IHZhbHVlLCBfX3UxNiBpbmRleCwKKwkJCQkgIHZvaWQg
KmRhdGEsIF9fdTE2IHNpemUsIGludCB0aW1lb3V0KQogewogCXN0cnVjdCB1c2JfZGV2aWNl
ICp1c2JfZGV2ID0gYXR1c2ItPnVzYl9kZXY7CiAJaW50IHJldDsKQEAgLTkxLDggKzkwLDMw
IEBAIHN0YXRpYyBpbnQgYXR1c2JfY29udHJvbF9tc2coc3RydWN0IGF0dXNiICphdHVzYiwg
dW5zaWduZWQgaW50IHBpcGUsCiAJaWYgKGF0dXNiLT5lcnIpCiAJCXJldHVybiBhdHVzYi0+
ZXJyOwogCi0JcmV0ID0gdXNiX2NvbnRyb2xfbXNnKHVzYl9kZXYsIHBpcGUsIHJlcXVlc3Qs
IHJlcXVlc3R0eXBlLAotCQkJICAgICAgdmFsdWUsIGluZGV4LCBkYXRhLCBzaXplLCB0aW1l
b3V0KTsKKwlyZXQgPSB1c2JfY29udHJvbF9tc2dfcmVjdih1c2JfZGV2LCAwLCByZXF1ZXN0
LCByZXF1ZXN0dHlwZSwKKwkJCQkgICB2YWx1ZSwgaW5kZXgsIGRhdGEsIHNpemUsIHRpbWVv
dXQsIEdGUF9LRVJORUwpOworCWlmIChyZXQgPCAwKSB7CisJCWF0dXNiLT5lcnIgPSByZXQ7
CisJCWRldl9lcnIoJnVzYl9kZXYtPmRldiwKKwkJCSIlczogcmVxIDB4JTAyeCB2YWwgMHgl
eCBpZHggMHgleCwgZXJyb3IgJWRcbiIsCisJCQlfX2Z1bmNfXywgcmVxdWVzdCwgdmFsdWUs
IGluZGV4LCByZXQpOworCX0KKworCXJldHVybiByZXQ7Cit9CisKK3N0YXRpYyBpbnQgYXR1
c2JfY29udHJvbF9tc2dfc2VuZChzdHJ1Y3QgYXR1c2IgKmF0dXNiLCBfX3U4IHJlcXVlc3Qs
IF9fdTggcmVxdWVzdHR5cGUsCisJCQkJICBfX3UxNiB2YWx1ZSwgX191MTYgaW5kZXgsCisJ
CQkJICB2b2lkICpkYXRhLCBfX3UxNiBzaXplLCBpbnQgdGltZW91dCkKK3sKKwlzdHJ1Y3Qg
dXNiX2RldmljZSAqdXNiX2RldiA9IGF0dXNiLT51c2JfZGV2OworCWludCByZXQ7CisKKwlp
ZiAoYXR1c2ItPmVycikKKwkJcmV0dXJuIGF0dXNiLT5lcnI7CisKKwlyZXQgPSB1c2JfY29u
dHJvbF9tc2dfc2VuZCh1c2JfZGV2LCAwLCByZXF1ZXN0LCByZXF1ZXN0dHlwZSwKKwkJCQkg
ICB2YWx1ZSwgaW5kZXgsIGRhdGEsIHNpemUsIHRpbWVvdXQsIEdGUF9LRVJORUwpOwogCWlm
IChyZXQgPCAwKSB7CiAJCWF0dXNiLT5lcnIgPSByZXQ7CiAJCWRldl9lcnIoJnVzYl9kZXYt
PmRldiwKQEAgLTEwNyw4ICsxMjgsNyBAQCBzdGF0aWMgaW50IGF0dXNiX2NvbW1hbmQoc3Ry
dWN0IGF0dXNiICphdHVzYiwgdTggY21kLCB1OCBhcmcpCiAJc3RydWN0IHVzYl9kZXZpY2Ug
KnVzYl9kZXYgPSBhdHVzYi0+dXNiX2RldjsKIAogCWRldl9kYmcoJnVzYl9kZXYtPmRldiwg
IiVzOiBjbWQgPSAweCV4XG4iLCBfX2Z1bmNfXywgY21kKTsKLQlyZXR1cm4gYXR1c2JfY29u
dHJvbF9tc2coYXR1c2IsIHVzYl9zbmRjdHJscGlwZSh1c2JfZGV2LCAwKSwKLQkJCQkgY21k
LCBBVFVTQl9SRVFfVE9fREVWLCBhcmcsIDAsIE5VTEwsIDAsIDEwMDApOworCXJldHVybiBh
dHVzYl9jb250cm9sX21zZ19zZW5kKGF0dXNiLCBjbWQsIEFUVVNCX1JFUV9UT19ERVYsIGFy
ZywgMCwgTlVMTCwgMCwgMTAwMCk7CiB9CiAKIHN0YXRpYyBpbnQgYXR1c2Jfd3JpdGVfcmVn
KHN0cnVjdCBhdHVzYiAqYXR1c2IsIHU4IHJlZywgdTggdmFsdWUpCkBAIC0xMTYsOSArMTM2
LDggQEAgc3RhdGljIGludCBhdHVzYl93cml0ZV9yZWcoc3RydWN0IGF0dXNiICphdHVzYiwg
dTggcmVnLCB1OCB2YWx1ZSkKIAlzdHJ1Y3QgdXNiX2RldmljZSAqdXNiX2RldiA9IGF0dXNi
LT51c2JfZGV2OwogCiAJZGV2X2RiZygmdXNiX2Rldi0+ZGV2LCAiJXM6IDB4JTAyeCA8LSAw
eCUwMnhcbiIsIF9fZnVuY19fLCByZWcsIHZhbHVlKTsKLQlyZXR1cm4gYXR1c2JfY29udHJv
bF9tc2coYXR1c2IsIHVzYl9zbmRjdHJscGlwZSh1c2JfZGV2LCAwKSwKLQkJCQkgQVRVU0Jf
UkVHX1dSSVRFLCBBVFVTQl9SRVFfVE9fREVWLAotCQkJCSB2YWx1ZSwgcmVnLCBOVUxMLCAw
LCAxMDAwKTsKKwlyZXR1cm4gYXR1c2JfY29udHJvbF9tc2dfc2VuZChhdHVzYiwgQVRVU0Jf
UkVHX1dSSVRFLCBBVFVTQl9SRVFfVE9fREVWLAorCQkJCSAgICAgIHZhbHVlLCByZWcsIE5V
TEwsIDAsIDEwMDApOwogfQogCiBzdGF0aWMgaW50IGF0dXNiX3JlYWRfcmVnKHN0cnVjdCBh
dHVzYiAqYXR1c2IsIHU4IHJlZykKQEAgLTEzMyw5ICsxNTIsOCBAQCBzdGF0aWMgaW50IGF0
dXNiX3JlYWRfcmVnKHN0cnVjdCBhdHVzYiAqYXR1c2IsIHU4IHJlZykKIAkJcmV0dXJuIC1F
Tk9NRU07CiAKIAlkZXZfZGJnKCZ1c2JfZGV2LT5kZXYsICIlczogcmVnID0gMHgleFxuIiwg
X19mdW5jX18sIHJlZyk7Ci0JcmV0ID0gYXR1c2JfY29udHJvbF9tc2coYXR1c2IsIHVzYl9y
Y3ZjdHJscGlwZSh1c2JfZGV2LCAwKSwKLQkJCQlBVFVTQl9SRUdfUkVBRCwgQVRVU0JfUkVR
X0ZST01fREVWLAotCQkJCTAsIHJlZywgYnVmZmVyLCAxLCAxMDAwKTsKKwlyZXQgPSBhdHVz
Yl9jb250cm9sX21zZ19yZWN2KGF0dXNiLCBBVFVTQl9SRUdfUkVBRCwgQVRVU0JfUkVRX0ZS
T01fREVWLAorCQkJCSAgICAgMCwgcmVnLCBidWZmZXIsIDEsIDEwMDApOwogCiAJaWYgKHJl
dCA+PSAwKSB7CiAJCXZhbHVlID0gYnVmZmVyWzBdOwpAQCAtODA1LDggKzgyMyw3IEBAIHN0
YXRpYyBpbnQgYXR1c2JfZ2V0X2FuZF9zaG93X3JldmlzaW9uKHN0cnVjdCBhdHVzYiAqYXR1
c2IpCiAJCXJldHVybiAtRU5PTUVNOwogCiAJLyogR2V0IGEgY291cGxlIG9mIHRoZSBBVE1l
Z2EgRmlybXdhcmUgdmFsdWVzICovCi0JcmV0ID0gYXR1c2JfY29udHJvbF9tc2coYXR1c2Is
IHVzYl9yY3ZjdHJscGlwZSh1c2JfZGV2LCAwKSwKLQkJCQlBVFVTQl9JRCwgQVRVU0JfUkVR
X0ZST01fREVWLCAwLCAwLAorCXJldCA9IGF0dXNiX2NvbnRyb2xfbXNnX3JlY3YoYXR1c2Is
IEFUVVNCX0lELCBBVFVTQl9SRVFfRlJPTV9ERVYsIDAsIDAsCiAJCQkJYnVmZmVyLCAzLCAx
MDAwKTsKIAlpZiAocmV0ID49IDApIHsKIAkJYXR1c2ItPmZ3X3Zlcl9tYWogPSBidWZmZXJb
MF07CkBAIC04NjEsOCArODc4LDcgQEAgc3RhdGljIGludCBhdHVzYl9nZXRfYW5kX3Nob3df
YnVpbGQoc3RydWN0IGF0dXNiICphdHVzYikKIAlpZiAoIWJ1aWxkKQogCQlyZXR1cm4gLUVO
T01FTTsKIAotCXJldCA9IGF0dXNiX2NvbnRyb2xfbXNnKGF0dXNiLCB1c2JfcmN2Y3RybHBp
cGUodXNiX2RldiwgMCksCi0JCQkJQVRVU0JfQlVJTEQsIEFUVVNCX1JFUV9GUk9NX0RFViwg
MCwgMCwKKwlyZXQgPSBhdHVzYl9jb250cm9sX21zZ19yZWN2KGF0dXNiLCBBVFVTQl9CVUlM
RCwgQVRVU0JfUkVRX0ZST01fREVWLCAwLCAwLAogCQkJCWJ1aWxkLCBBVFVTQl9CVUlMRF9T
SVpFLCAxMDAwKTsKIAlpZiAocmV0ID49IDApIHsKIAkJYnVpbGRbcmV0XSA9IDA7CkBAIC05
ODUsOCArMTAwMSw3IEBAIHN0YXRpYyBpbnQgYXR1c2Jfc2V0X2V4dGVuZGVkX2FkZHIoc3Ry
dWN0IGF0dXNiICphdHVzYikKIAkJcmV0dXJuIC1FTk9NRU07CiAKIAkvKiBGaXJtd2FyZSBp
cyBuZXcgZW5vdWdoIHNvIHdlIGZldGNoIHRoZSBhZGRyZXNzIGZyb20gRUVQUk9NICovCi0J
cmV0ID0gYXR1c2JfY29udHJvbF9tc2coYXR1c2IsIHVzYl9yY3ZjdHJscGlwZSh1c2JfZGV2
LCAwKSwKLQkJCQlBVFVTQl9FVUk2NF9SRUFELCBBVFVTQl9SRVFfRlJPTV9ERVYsIDAsIDAs
CisJcmV0ID0gYXR1c2JfY29udHJvbF9tc2dfcmVjdihhdHVzYiwgQVRVU0JfRVVJNjRfUkVB
RCwgQVRVU0JfUkVRX0ZST01fREVWLCAwLCAwLAogCQkJCWJ1ZmZlciwgSUVFRTgwMjE1NF9F
WFRFTkRFRF9BRERSX0xFTiwgMTAwMCk7CiAJaWYgKHJldCA8IDApIHsKIAkJZGV2X2Vycigm
dXNiX2Rldi0+ZGV2LCAiZmFpbGVkIHRvIGZldGNoIGV4dGVuZGVkIGFkZHJlc3MsIHJhbmRv
bSBhZGRyZXNzIHNldFxuIik7Cg==
--------------0yDdLORdt2pZG9ogRqTUpcCN--

